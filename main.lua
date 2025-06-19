function love.load()
    
    gralphabet = require("gralphabet")
    gralphabet:init()
    
end

function love.update()
    
    gralphabet:cycle()
    
end

function love.keypressed(key)
    
    if key == "escape" then 
        love.event.push("quit")
    end
    
end

function love.draw()
    
    gralphabet:draw_canvas()
    
end
