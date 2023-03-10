# DO NOT CHANGE THE FOLLOWING 3 LINES UNLESS YOU KNOW
# WHAT YOU ARE DOING!
# set CONTINUE_WO_HOTWORD to true to be able to chain
# commands without need of a hotword in between:
#
const CONTINUE_WO_HOTWORD = false

# set a local const LANG:
#
const LANG = get_language()



# Slots:
# Name of slots to be extracted from intents:
#
const SLOT_DEVICE = "device"
const SLOT_LIGHT_SETTINGS = "light_settings"
const SLOT_ON_OR_OFF = "on_or_off"
const SLOT_ROOM = "room"


# name of entries in config.ini:
#

#
# link between actions and intents:
# intent is linked to action::Funktion
#
# register_intent_action("TEMPLATE_SKILL", TEMPLATE_INTENT_action)
register_on_off_action(on_or_off_action)
register_intent_action("Susi:LightSettings", light_settings_action)
