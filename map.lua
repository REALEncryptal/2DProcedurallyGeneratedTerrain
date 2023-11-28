local map = {
    tiles = {}
}
--create matrix iterate funciton
function iterate(func)
    for x = 1, #map.tiles do
        for y = 1, #map.tiles[x] do
            func(x, y)
        end
    end
end

function map.new(width, height)
    map.tiles = {}
    for x = 1, width do
        map.tiles[x] = {}
        for y = 1, height do
            map.tiles[x][y] = 0
        end
    end

    -- fill with dirt
    iterate(function(x, y)
        map.tiles[x][y] = 1
    end)

    -- fill anything below 40 with stone
    iterate(function(x, y)
        if y > 50 then
            map.tiles[x][y] = 2
        end
    end)

    -- fill anything above 20 with air
    iterate(function(x, y)
        if y < 20 then
            map.tiles[x][y] = 0
        end
    end)

    math.randomseed(os.time()/100)
    local a1 = math.random(8000,12000)/10000
    local a2 = math.random(9000,11000)/10000
    local a3 = math.random(9000,11000)/10000
    local a4 = math.random(9000,11000)/10000
    local a5 = math.random(-1000, 1000)/100
    local a6 = math.random(-1000, 1000)/100
    local a7 = math.random(-1000, 1000)/100

    iterate(function(x, y)
        local dist = math.sin(x/10)*10 
        dist = (dist + math.cos(x/4*a2 + a6)*6)/2
        dist = (dist + math.sin(x/5.4*a3)*2.7)/2
        dist = (dist + math.cos(x/50*a1+a7)*6)/2
        dist = dist + math.sin(x/4*a4 + a5)/4*a1

        if y < 30 + dist then
            map.tiles[x][y] = 0
        end
    end)

    -- remove single blocks indents or outdents
    iterate(function(x, y)
        if x == 1 or x > 100 then return end
        if y > 40 then return end

        local a = map.tiles[x + 1][y]
        local b = map.tiles[x - 1][y]
        local c = map.tiles[x][y]
        print(x)
        if (a + b + c) == 1 then
            map.tiles[x][y] = 0
        elseif (a + b == 2 and c == 0) then
            map.tiles[x][y] = 1
        end
    end)
end

function map.render(startx, starty, endx, endy)
    for x = startx, endx do
        for y = starty, endy do
            if map.tiles[x][y] == 1 then
                love.graphics.setColor(0.28, 0.18, 0.05)
            elseif map.tiles[x][y] == 2 then
                love.graphics.setColor(0.5, 0.5, 0.5)
            elseif map.tiles[x][y] == 3 then
                love.graphics.setColor(0.1, 0.8, 0.1)
            end

            -- Only draw if the tile is not 0
            if map.tiles[x][y] ~= 0 then
                love.graphics.rectangle("fill", (x - startx) * 8 - 8, (y - starty) * 8 - 8, 8, 8)
                -- Add a 1px outline
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", (x - startx) * 8 - 8, (y - starty) * 8 - 8, 8, 8)
            end
        end
    end
end


return map