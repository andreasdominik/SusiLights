# SusiLights - Snips/Rhasspy Skill

Simple skill to switch lights on or off with voice commands with a
Snips-like home assistant (i.e. Rhasspy).     
The skill is written in Julia with the HermesMQTT.jl framework.

### Julia

This skill is (like the entire HermesMQTT.jl framework) written in the
modern programming language Julia (because Julia is faster
then Python and coding is much much easier and much more straight forward).
However "Pythonians" often need some time to get familiar with Julia.

If you are ready for the step forward, start here: https://julialang.org/

Learn more about writing skills in Julia with HermesMQTT.jl here: 
 [![](https://img.shields.io/badge/docs-latest-blue.svg)](https://andreasdominik.github.io/HermesMQTT.jl/dev)



## Installation

The skill can be installed from within the Julia REPL with the following
commands, if the HermesMQTT.jl framework is already installed 
and configured:

```julia
using HermesMQTT

install("SusiLights")
```

If the Rhasspy server is running (recommended) the installer will
install the skill on the local machine and upload intents and slots
to the Rhasspy server (locally or remote in a server-satellite setup).

## Usage

Basic idea is to configure a set of lights in different rooms of the house 
in the config.ini file. 
Then the skill can be used to switch the lights on or off by voice command.



## Light definitions

Lights are defined as unique combinations of `room:light` tuples 
in the config.ini file.
Each light must define a driver and a list of driver specific parameters.

In addition a 
joker can be defined to match any type of light in a room, if there is only one
light in the room.
By default the joker is *light*, with the result, that
the command *switch on the light in the xyzroom* always matches the light 
in the room. If there are more than one lights in the room, the joker only
matches if one of the lights is of the joker type (i.e. `light`).

Currently supported drivers include shelly devices
(maybe all types of shelly devices may be switched on/off
with the shelly1 driver) and gpio pins of a raspberry pi.

- shelly1 (switch)
- shellybulb (color bulb)
- shellyplug (switch)
- shelly25 (switch)
- gpio (switch)

Intent and light definitions rely on the same room and device names, defined
as slot lists `rooms` and `devices` by the *HermesMQTT* framework.
Add additional light types as devices there as well as room names.

Make sure, that room-names match with site-IDs in a server-satellite Rhasspy
setup. In this case the skill will firstly try to get a room name from the
voice command. If missing (e.g. *"switch on the light"*), the site-ID of the
satellite on which the command is recorded will be used as room name with the
result that always the light in the current room will be switched on.
In summary it is a good idea to always define the main light in a room as
joker light.


### Example config.ini file:

```ini
joker = light

livingroom:light = shelly1, 192.168.1.42, rhasspy, passwd
livingroom:floor_lamp = shelly1, 192.168.1.43, rhasspy, passwd
kitchen:ceiling_lamp = shellybulb, 192.168.1.45, rhasspy, passwd
office:desk_lamp = shellyplug, 192.168.1.176, rhasspy, passwd

lanay:light = gpio, 17, 192.168.1.47, rhasspy, passwd
```

## Drivers
### GPIO switching

If lights are connected to GPIO pins of a Raspberry Pi (or similar), the driver
gpio can be used. In this case on the Raspberry Pi `pigpio` must be installed
and ssh access must be enabled. The skill will then use `ssh` to login to the 
pi or `sshpass` to login with a password (both must be available, of course).

### Shelly devices

All types of shelly devices may be switched on/off with the shelly1 driver.
The shelly-devices must be configured with a fixed IP address or hostname 
as client in the local network. Following Rhasspy-style it is not necessary
nor recommended to use the shelly cloud service!

### Other drivers

Other hardware drivers may be added easily as log as they can be 
controlled via http or MQTT requests. 

Because the shelly devices are are low-price, easy to use and 
cloud-free, the autor of this skill discontinued to use other hardware. But
if somebody has an installation with Hue, Ikea or other lights, please 
contact me and we can easily add a driver for your hardware 
(if you help with testing ;-).

## Slots

The skill uses slots of the *HermesMQTT* framework to define the rooms and
devices and doe not come with own slot lists.

## Intents

Currently only the intent `Susi:on_off` is supported.    
`Susi:LightSettings` is defined, but not yet implemented (change colour 
or brightness).


## Language support
Of course home automation skills are language dependent. Within the HermesMQTT.jl
Framework a Skill can support multiple languages by defining the intents for
different languages in the `profiles/<language>` subdirectory of the repository and
by defining dialogues for different languages in the config.ini file of the skill.

Currently English and German are supported.

Native speakers of other languages are welcome to contribute to the skill to make 
it available for more languages.
No changes in the code are required to support a new language.