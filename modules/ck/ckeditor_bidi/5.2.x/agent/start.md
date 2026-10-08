<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor BiDi Buttons — agent index

Adds **RTL/LTR direction buttons** to the CKEditor 5 toolbar; they set the HTML `dir`
attribute on block elements for bi-directional content. One CKEditor 5 plugin, one setting.
Depends on `ckeditor5`. No routes, permissions, services, or Drush. No `configure` route
(`data.json` `configure` = null) — you configure it inside each text format's editor form.

- **Add the button to a format's toolbar; the `switch_only` setting; where config is stored** →
  [configure/toolbar.md](configure/toolbar.md)
- **The CKEditor 5 plugin definition, allowed elements, and JS `switchOnly` config** →
  [api/plugin.md](api/plugin.md)

Key facts:
- Toolbar item id: **`direction`**. CKEditor 5 plugin id: **`ckeditor_bidi_ckeditor5`**
  (class `Bidi`, `direction.Direction`).
- Only setting: `switch_only` (bool, default `false`) — "Never remove direction, only switch".
  Stored on the `editor` config entity at
  `editor.editor.<format>` → `settings.plugins.ckeditor_bidi_ckeditor5.switch_only`.
- Enabling the button = adding `direction` to `editor.editor.<format>` →
  `settings.toolbar.items`.
