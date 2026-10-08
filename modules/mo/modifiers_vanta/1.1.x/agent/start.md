<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vanta Modifier (modifiers_vanta) — agent index

**Adds an animated Vanta.js (WebGL) background to elements via a Modifiers plugin + Paragraph bundle.**

- **Version:** 1.1.x
- **Core:** ^9 || ^10 || ^11
- **Requires:** modifiers, paragraphs, options; the Vanta.js JS library in `libraries/`.
- **Plugin:** `VantaModifier` Modifier plugin (`src/Plugin/Modifier/`); JS in `js/`.
- **No routes / no permissions / no services.** Config is entered as Paragraph field values on a `field_modifiers` field.

**Security:** No routes, endpoints, or user input sinks; purely attaches a JS library and emits drupalSettings at render time. No security findings.
