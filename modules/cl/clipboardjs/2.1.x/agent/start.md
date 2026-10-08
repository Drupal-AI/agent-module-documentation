<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clipboard.js — agent index

Integrates the external **clipboard.js** JS library: "copy to clipboard" **field formatters**
and **theme hooks**. No settings page, no permissions, no Drush. Requires the clipboard.js
library at `DRUPAL_ROOT/libraries/clipboard/dist/clipboard.js`.

- **Field formatters (ids, field types, settings) & Manage display** →
  [configure/formatters.md](configure/formatters.md)
- **Theme hooks, render/Form API usage, libraries & the external dependency** →
  [theming/render.md](theming/render.md)

Key facts:
- Four formatters: `clipboard_button`, `clipboard_snippet`, `clipboard_textfield`,
  `clipboard_textarea`. Field types: string, email, link, integer, decimal, float, slug,
  slug_path. Settings: `label` ("Click to copy"), `alert_style` (`tooltip`|`alert`|`none`),
  `alert_text` ("Copied!").
- Four theme hooks: `clipboardjs_button`, `clipboardjs_snippet`, `clipboardjs_textarea`,
  `clipboardjs_textfield` (vars `value`, `label`, `alert_style`, `alert_text`, `height`,
  `width`, `attributes`).
- Front-end library `clipboardjs/drupal` (depends on `clipboardjs/clipboardjs`, the external
  lib); `hook_requirements()` errors on the status report if the library is absent.
- No configure route; config is per-formatter display settings only
  (`field.formatter.settings.clipboard*`).
