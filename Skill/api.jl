#
# API function go here, to be called by the
# skill-actions (and trigger-actions):
#

# device is a string: "room:lamp" 
# action is a string: "on" or "off"
#
function switch_lamp(device, action)

    # get params for device:
    params = get_config(device, multiple=true)
    if isnothing(params) || length(params) < 2
        print_log("ERROR: Config for device $device incomplete.")
        return
    end
    driver = params[1]

    # like: living_room:light = shelly1, 192.168.1.42, rhasspy, passwd
    #
    if driver == "shelly1" || driver == "shellybulb" || driver == "shellyplug"
        ip = params[2]
        user = passwd = nothing
        if length(params) > 2
            user = params[3]
        end
        if length(params) > 3
            passwd = params[4]
        end
        succ = switch_shelly_1(ip, action, user=user, password=passwd)

    # like: living_room:light = shelly1, 0, 192.168.1.42, rhasspy, passwd
    #
    elseif driver == "shelly25"
        ip = params[2]
        user = passwd = nothing
        if length(params) > 2
            relay = params[3]
        end
        if length(params) > 3
            user = params[4]
        end
        if length(params) > 4
            passwd = params[5]
        end
        succ = switch_shelly_25(ip, relay, action, user=user, password=passwd)

    # like: living_room:light = gpio, 17, 192.168.1.47, rhasspy, passwd
    #
    elseif driver == "gpio"
        ip = params[2]
        user = passwd = nothing
        if length(params) > 2
            gpio = params[3]
        end
        if length(params) > 3
            user = params[4]
        end
        if length(params) > 4
            passwd = params[5]
        end
        succ = set_gpio(ip, gpio, action, user=user, password=passwd)
    else
        print_log("ERROR: Unknown driver $driver for device $device.")
    end
end