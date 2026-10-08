<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analog Digital Clock provides a single block that renders the current time in one of four selectable visual skins.

---

The block plugin `AnalogDigitalClockSkin` (`src/Plugin/Block/`) reads the configured skin from `analog_digital_clock.settings` and renders the `analogDigitalLightDarkSkin` theme with `#cache: max-age 0` so the clock stays live. The clock runs client-side in JavaScript using the browser/system time (not server time). A config form at `/admin/config/analog_digital_clock` (`src/Form/AnalogDigitalClock.php`, permission `administer site configuration`) lets an admin pick skin 1-4: simple digital with date, 24-hour digital with date, analog, or animated digital.

The analog skin requires the third-party `snap.svg` library placed at `libraries/snap.svg/snap.svg-min.js` (see the module README); the digital skins need no extra library. Setup is: enable the module, choose a skin on the settings form, then place the "Analog Digital Clock" block in a region via Block layout. The module declares an `administer analog_digital_clock` permission, but its settings route is actually gated by core's `administer site configuration`.

---
- Place the "Analog Digital Clock" block in any theme region.
- Show a live clock that updates in the visitor's browser.
- Pick the simple digital-with-date skin.
- Pick the 24-hour digital-with-date skin.
- Use the analog clock face skin (requires snap.svg library).
- Use the animated digital skin.
- Change the active skin from `/admin/config/analog_digital_clock`.
- Install snap.svg to `libraries/snap.svg/snap.svg-min.js` for the analog face.
- Display the clock in a header or sidebar region.
- Add multiple placements of the block in different regions.
- Rely on system/browser time with no server configuration.
- Keep the clock uncached so it always shows the current time.
- Restrict the settings form to site administrators.
- Use it as a lightweight dashboard time widget.
- Combine with block visibility conditions to show it on selected pages.
- Theme the clock output by overriding the `analogDigitalLightDarkSkin` template.
