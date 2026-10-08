<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Color Button (colorbutton) — agent index

**Registers the CKEditor 4 Color Button plugin (TextColor + BGColor toolbar buttons) for Drupal's CKEditor.**

- **Version:** 8.x-1.x (info.yml `8.x-1.5`)
- **Core:** ^9.3 || ^10 (Drupal 10 contrib, CKEditor **4** only — CK4 removed from D10 core)
- **Dependencies:** `ckeditor` (contrib CK4), `panelbutton`; external JS lib at `/libraries/colorbutton/plugin.js` (v4.5.6+).
- **Plugin:** `src/Plugin/CKEditorPlugin/ColorButton.php` (buttons `TextColor`, `BGColor`); config schema `config/schema/colorbutton.schema.yml`.
- **Setup:** per-format CKEditor toolbar builder; optional allowed-hex-colors list; requires `<span style>` in allowed HTML. `hook_requirements()` checks the library.

**Security:** editor-plugin only; no routes, permissions, or request handling. Inline `style` on `<span>` is the intended output (format/HTML-filter controlled by the admin).
