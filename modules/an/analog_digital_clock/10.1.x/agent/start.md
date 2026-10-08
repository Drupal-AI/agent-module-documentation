<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analog Digital Clock (analog_digital_clock) — agent index

**A block that shows the current time in one of four skins (simple digital, 24h digital, analog, animated); time is rendered client-side.**

- **Version:** 10.1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Configure:** `analog_digital_clock.settings` -> `/admin/config/analog_digital_clock` (permission `administer site configuration`)
- **Block:** plugin `analog_digital_clock_skin` (`AnalogDigitalClockSkin`), renders theme `analogDigitalLightDarkSkin`, `#cache max-age 0`.
- **Config key:** `analog_digital_clock.settings:analog_digital_clock_skin` (1-4).
- **Library:** analog skin needs `snap.svg` at `libraries/snap.svg/snap.svg-min.js`.

**Solution docs**
- **Block, settings form, config object/schema, theme hook, libraries, how to operate it** → [config/settings.md](config/settings.md)

**Notes:** Single admin config route gated by `administer site configuration` (a `ConfigFormBase`, so CSRF-protected); no anonymous, mutating, or data endpoints. The skin value is used only in numeric Twig comparisons, never printed into markup. Declares an `administer analog_digital_clock` permission (restrict access) that the routing does not actually use.
