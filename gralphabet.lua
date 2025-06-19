local function hex2love(hex)
    local r,g,b
    r = tonumber(string.sub(hex, 1,2), 16)
    g = tonumber(string.sub(hex, 3,4), 16)
    b = tonumber(string.sub(hex, 5,6), 16)
    return {r/255, g/255, b/255}
end

local gra = {}

function gra:init()
    
    -- memory
    self.mem = {}
    for i = 0, 65535 do
        self.mem[i] = 0
    end
    self.ptr = 0
    self.buff = 0
    
    self.program = {}
    self.pc = 0
    self.instr = ""
    self.program_length = 0
    
    self:load_program("oodddddoc")
    
    -- display
    
    self.screen_width, self.screen_height = 64, 64
    self.screen = {}
    for i = 0, self.screen_width * self.screen_height do
        self.screen[i] = love.math.random(0, 255)
    end
    
    self.pal = self.load_palette(1)
    
    -- love2d
    
    self.canvas = love.graphics.newCanvas(self.screen_width, self.screen_height)
    self.canvas:setFilter("nearest")
    
    self:update_canvas() -- temp
    
end

function gra:load_program(str)
    
    str = string.gsub(str, "%s+", "") -- remove whitespace
    self.program = {}
    local strlen = string.len(str)
    self.program_length = strlen
    -- program starts at index 0
    for i = 1, strlen do
        self.program[i - 1] = string.sub(str, i, i)
    end
    
end

function gra:cycle()
    
    if self.pc < self.program_length then
        self.instr = self.program[self.pc]
        self.pc = self.pc + 1
        -- remember : we fetch instr, then increment pc, then execute
        
        self:execute()
    else
        if self.pc == self.program_length then
            print() -- print newline for the output
            self.pc = self.pc + 1 -- end execution, now pc = program_length + 1
        end
    end
    
end

function gra:execute()
    
    local char = self.instr
    print(string.format("%d - %s", self.pc - 1, char))
    
    if char == "a" then
        -- a ADD - add value in buffer to mem[ptr] (buffer is unchanged)
        
    elseif char == "b" then
        -- b BACKWARDS - decrement ptr
        self.ptr = self.ptr - 1
        
    elseif char == "c" then
        -- c CHAR - output ascii value of mem[ptr]
        local char_out = string.char(self.mem[self.ptr])
        io.write(char_out)
        
    elseif char == "d" then
        -- d DOUBLE - double the value in mem[ptr]
        self.mem[self.ptr] = 2 * self.mem[self.ptr]
        
    elseif char == "e" then
        -- e ENDIF - execution continues
        
    elseif char == "f" then
        -- f FORWARDS - increment ptr
        self.ptr = self.ptr + 1
        
    elseif char == "g" then
        -- g GOTO - set ptr to the value inside mem[ptr]
        
    elseif char == "h" then
        -- h HALF - halve the value inside mem[ptr] (floored)
        
    elseif char == "i" then
        -- i IF - execution continues forward if mem[ptr] is 0, else execution continues after matching <e>
        
    elseif char == "j" then
        -- j JUMP - execution skips the next (mem[ptr] + 1) instructions
        
    elseif char == "k" then
        -- k KEY - store value of current key pressed into mem[ptr]
        
    elseif char == "l" then
        -- l LOOP - continue execution past the matching <u> if mem[ptr] is 0, else execution continues forward
        
    elseif char == "m" then
        -- m MINUS - substract 1 from mem[ptr]
        self.mem[self.ptr] = self.mem[self.ptr] - 1
        
    elseif char == "n" then
        -- n NUMBER - output the number inside mem[ptr]
        
    elseif char == "o" then
        -- o ONE - add 1 to mem[ptr]
        self.mem[self.ptr] = self.mem[self.ptr] + 1
        
    elseif char == "p" then
        -- p PUT - put contents of buffer in mem[ptr]
        
    elseif char == "q" then
        -- q QUERY - read one byte of input into mem[ptr]
        
    elseif char == "r" then
        -- r RANDOM - mem[ptr] = random(0, buffer)
        
    elseif char == "s" then
        -- s SUBSTRACT - remove value in buffer from mem[ptr] (buffer is unchanged)
        
    elseif char == "t" then
        -- t TIMES - multiply mem[ptr] by buffer
        
    elseif char == "u" then
        -- u UNTIL - execution continues forward if mem[ptr] is 0, else go back to matching <l>
        
    elseif char == "v" then
        -- v VIEW - set mem[ptr] to the value of screen[buffer]
        
    elseif char == "w" then
        -- w WRAP - set mem[ptr] to mem[ptr] % buffer
        
    elseif char == "x" then
        -- x PIXEL - set screen[buffer] = mem[ptr]
        
    elseif char == "y" then
        -- y YANK - copy mem[ptr] into buffer
        
    elseif char == "z" then
        -- z ZERO - set mem[ptr] to zero
        
    else
        error(string.format("%s is not a valid instr", char))
    end
    
end

-- display functions

function gra:update_canvas()
    
    love.graphics.setCanvas(self.canvas)
   
    for i = 0, self.screen_height - 1 do
        for j = 0, self.screen_width - 1 do
            local col = self.screen[(i * self.screen_height) + j] % 8
            love.graphics.setColor(self.pal[col])
            love.graphics.points(i + 0.5, j + 0.5)
        end
    end
    
    love.graphics.setColor(1,1,1)
    love.graphics.setCanvas()
    
end

function gra:draw_canvas()
    
    love.graphics.draw(self.canvas, 0, 0, 0, 12)

end

function gra.load_palette(n)
    local palettes = {
        {"ffffff", "ff0000", "00ff00", "0000ff", "00ffff", "ff00ff", "ffff00", "000000"}, -- wrgbcmyk
        {"2b0f54", "ab1f65", "ff4f69", "fff7f8", "ff8142", "ffda45", "3368dc", "49e7ec"}, -- FunkyFuture palette
        {"ffffff", "fcf660", "b2d942", "52c33f", "166e7a", "254d70", "252446", "201533"} -- Citrink palette
    }
    
    local love_colors = {}
    for i = 1, 8 do
        love_colors[i - 1] = hex2love(palettes[n][i])
    end
    
    return love_colors
end

-- debug functions

function gra:print_cells(a, b)
    print("----------")
    for i = a, b do
        io.write(string.format("", self.mem[i]))
    end
end

return gra
