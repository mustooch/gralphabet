local alpha = {}

function alpha:init()
    
    -- memory
    self.mem = {}
    for i = 0, 65535 do
        self.mem[i] = 0
    end
    
    self.ptr = 0
    self.buff = 0
    
end

    

function alpha:opcodes()
    
    -- a ADD - add buffer to mem[ptr]
    
    -- b BACKWARDS - decrement ptr
    
    -- c CHAR - output ascii value of mem[ptr]
    
    -- d DELETE - delete mem[ptr], store value in buffer
    
    -- e
    
    -- f FORWARDS - increment ptr
    
    -- g GOTO - set ptr to the value inside mem[ptr]
    
    -- h
    
    -- i
    
    -- j
    
    -- k
    
    -- l LOOP - loop execution until <u>
    
    -- m MINUS - remove one from memory pointer
    
    -- n NUMBER - output the number inside mem[ptr]
    
    -- o ONE - add one to mem[ptr]
    
    -- p PUT - put contents of buffer in mem[ptr]
    
    -- q
    
    -- r RANDOM - mem[ptr] = random(0, buffer)
    
    -- s 
    
    -- t
    
    -- u UNTIL - execution goes back to matching <l> if buffer is not 0, else execution continues forward
    
    -- v
    
    -- w
    
    -- x 
    
    -- y YANK - copy mem[ptr] into buffer
    
    -- z
    
end

return alpha
