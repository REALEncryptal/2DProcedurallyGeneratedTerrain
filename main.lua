_G.love = require("love")

local Camera = require("hump/camera")
local map = require("map")

local x = 0
local y = 0

function love.load()
    love.window.setMode(1920, 1080)

    camera = Camera(0,0)
    -- set background to a light cyan sky color
    love.graphics.setBackgroundColor(0.6, 0.7, 1.0)

    map.new(1920/8, 1080/8)
end

function love.update(dt)
    x = x + 2 * dt
    y = y + 1 * dt
end

function love.draw()
    camera:attach()
    -- do your drawing here

    -- display fps
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10)


    map.render(1+math.floor(x), 1+math.floor(y), 50 + math.floor(x), 50 + math.floor(y))


    camera:detach()
end