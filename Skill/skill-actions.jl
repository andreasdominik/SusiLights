#
# actions called by the main callback()
# provide one function for each intent, defined in the Snips/Rhasspy
# console.
#
# ... and link the function with the intent name as shown in config.jl
#
# The functions will be called by the main callback function with
# 2 arguments:
# + MQTT-Topic as String
# + MQTT-Payload (The JSON part) as a nested dictionary, with all keys
#   as Symbols (Julia-style).
#



function on_or_off_action(topic, payload)

    print_log("action on_or_off_action() in Susi:Lights started.")

    device = match_device_room(APP_NAME, payload, 
                    slot_device="device", slot_room="room")
println("***** device: $(device)")
    action = extract_slot_value(SLOT_ON_OR_OFF, payload, default="on")

    if !(action in ["on", "off"])
        publish_say(:no_on_or_off)
        print_log("action is not on or off.")
        return false
    end

    switch_lamp(device, action)
    return false
end


"""
    Susi_LightSettings_action(topic, payload)

Generated dummy action for the intent Susi:LightSettings.
This function will be executed when the intent is recognized.
"""
function light_settings_action(topic, payload)

    print_log("action Susi_LightSettings_action() started.")
    publish_end_session(:not_yet_implemented)
    return true
end
