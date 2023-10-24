local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local gcolor = require("gears.color")
local beautiful = require("beautiful")

local bg_normal = beautiful.tabbar_bg_normal or beautiful.bg_normal or "#ffffff"
local fg_normal = beautiful.tabbar_fg_normal or beautiful.fg_normal or "#000000"
local bg_focus = beautiful.tabbar_bg_focus or beautiful.bg_focus or "#000000"
local fg_focus = beautiful.tabbar_fg_focus or beautiful.fg_focus or "#ffffff"
local bg_focus_inactive = beautiful.tabbar_bg_focus_inactive or bg_focus
local fg_focus_inactive = beautiful.tabbar_fg_focus_inactive or fg_focus
local bg_normal_inactive = beautiful.tabbar_bg_normal_inactive or bg_normal
local fg_normal_inactive = beautiful.tabbar_fg_normal_inactive or fg_normal
local font = beautiful.tabbar_font or beautiful.font or "Hack 15"
local size = beautiful.tabbar_size or 24
local position = beautiful.tabbar_position or "top"

local function create(c, focused_bool, buttons, inactive_bool)
    local bg_temp = inactive_bool and bg_normal_inactive or bg_normal
    local fg_temp = inactive_bool and fg_normal_inactive or fg_normal
    if focused_bool then
        bg_temp = inactive_bool and bg_focus_inactive or bg_focus
        fg_temp = inactive_bool and fg_focus_inactive or fg_focus
    end

    local wid_temp = wibox.widget({
        {
            {
                { -- Left
                    wibox.widget.base.make_widget(
                        awful.titlebar.widget.iconwidget(c)
                    ),
                    -- spacing
                    wibox.widget {
                        widget = wibox.widget.separator,
                        orientation = "vertical",
                        forced_width = 2,
                        color = "#00000000",
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                { -- Title
                    wibox.widget.base.make_widget(
                        awful.titlebar.widget.titlewidget(c)
                    ),
                    widget = wibox.container.place,
                },
                { -- Right
                    widget = wibox.container.background,
                },
                layout = wibox.layout.align.horizontal,
            },
            buttons = buttons, -- handle mouse input
            widget = wibox.container.margin,
            top = 2,
            bottom = 2,
            right = 8,
            left = 8,
        },
        bg = bg_temp,
        fg = fg_temp,
        widget = wibox.container.background,
    })

    return wid_temp
end

return {
    layout = wibox.layout.flex.horizontal,
    create = create,
    position = position,
    size = size,
    bg_normal = bg_normal,
    bg_focus = bg_focus,
}
