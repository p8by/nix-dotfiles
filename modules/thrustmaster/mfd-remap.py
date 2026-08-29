#!/usr/bin/env python3
import threading
from evdev import InputDevice, UInput, ecodes

DEVICES = [
    {
        "path": "/dev/input/by-id/usb-Thrustmaster_F16_MFD_1-event-joystick",
        "name": "Thrustmaster F16 MFD 1 (Virtual)",
        "vendor": 0x044F,
        "product": 0xFF01,
    },
    {
        "path": "/dev/input/by-id/usb-Thrustmaster_F16_MFD_2-event-joystick",
        "name": "Thrustmaster F16 MFD 2 (Virtual)",
        "vendor": 0x044F,
        "product": 0xFF02,
    },
]

SOURCE_CODES = [304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315,
                316, 317, 318, 319, 704, 705, 706, 707, 708, 709, 710, 711,
                712, 713, 714, 715]

JOYSTICK_BUTTONS = [
    ecodes.BTN_TRIGGER, ecodes.BTN_THUMB, ecodes.BTN_THUMB2,
    ecodes.BTN_TOP, ecodes.BTN_TOP2, ecodes.BTN_PINKIE,
    ecodes.BTN_BASE, ecodes.BTN_BASE2, ecodes.BTN_BASE3,
    ecodes.BTN_BASE4, ecodes.BTN_BASE5, ecodes.BTN_BASE6,
    ecodes.BTN_DEAD,
]
TARGET_CODES = JOYSTICK_BUTTONS + [
    getattr(ecodes, f"BTN_TRIGGER_HAPPY{i}") for i in range(1, 16)
]

MAPPING = dict(zip(SOURCE_CODES, TARGET_CODES))

def handle_device(cfg):
    dev = InputDevice(cfg["path"])
    ui = UInput(
        {ecodes.EV_KEY: TARGET_CODES},
        name=cfg["name"], bustype=0x03,
        vendor=cfg["vendor"], product=cfg["product"], version=1,
    )
    dev.grab() 
    print(f"Remapping active: {cfg['name']}")
    for event in dev.read_loop():
        if event.type == ecodes.EV_KEY and event.code in MAPPING:
            ui.write(ecodes.EV_KEY, MAPPING[event.code], event.value)
            ui.syn()

if __name__ == "__main__":
    threads = [threading.Thread(target=handle_device, args=(d,), daemon=True) for d in DEVICES]
    for t in threads: t.start()
    for t in threads: t.join()
