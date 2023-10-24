local awful = require("awful")
local mylayout = {}
mylayout.name = "deck_double"

-- client_count: int
-- client_list: array
-- area: table

local function subdeck (p, client_count, clients, area, mfactor)
    mfactor = 0.7

    if client_count == 1 then
        local c = clients[1]
        local g = {
            x = area.x,
            y = area.y,
            width = area.width,
            height = area.height,
        }
        p.geometries[c] = g
        return
    end

    local xoffset = area.width * 0.5 * (1 - mfactor) / (client_count - 1)
    local yoffset = area.height * 0.5 * (1 - mfactor) / (client_count - 1)

    for idx = 1, client_count do
        local c = clients[idx]
        local g = {
            x = area.x + (idx - 1) * xoffset,
            y = area.y + (idx - 1) * yoffset,
            width = area.width - (xoffset * (client_count - 1)),
            height = area.height - (yoffset * (client_count - 1)),
        }
        p.geometries[c] = g
    end
end

function mylayout.arrange(p)
    local area = p.workarea
    local t = p.tag or screen[p.screen].selected_tag
    local mfactor = t.master_width_factor
    local client_count = #p.clients

    if client_count <= 2 or t.master_count == 0 or t.master_count == client_count then
        subdeck(p, client_count, p.clients, area, mfactor)
    else
        local client_count_left = t.master_count

        -- split clients

        local t1, t2 = {}, {}

        for k, v in pairs(p.clients) do
            if k <= client_count_left then
                table.insert(t1, v)
            else
                table.insert(t2, v)
            end
        end

        local subarea = {
            x = area.x,
            y = area.y,
            width = area.width * mfactor,
            height = area.height,
        }
        subdeck(p, client_count_left, t1, subarea, mfactor)

        subarea = {
            x = area.x + area.width * mfactor,
            y = area.y,
            width = area.width * (1 - mfactor),
            height = area.height,
        }
        subdeck(p, client_count - client_count_left, t2, subarea, mfactor)

    end
end

return mylayout
