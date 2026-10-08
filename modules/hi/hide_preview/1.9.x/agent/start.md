<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hide Preview Button — agent index

One `hook_form_alter` that removes the preview button from forms whose `form_id` matches a
configured pattern (regex or substring). No permissions of its own, no schema, no submodules.
Config UI at `/admin/config/hide_preview` (route `hide_preview.settings`, permission
`administer site configuration`).

- **Where patterns live, how matching works, which button elements are unset** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config: `hide_preview.settings` key `hide_preview.form_names` = array of pattern strings
  (one per line in the textarea).
- A pattern is treated as a **regex** if `preg_match($pattern, $form_id)` returns a capture;
  otherwise as a **substring** matched with `strpos($form_id, $pattern) !== FALSE`.
- Buttons removed: `actions.preview`, `actions.preview_draft`, `meta.preview`,
  `top.meta.preview` (the last two are the Gin theme's preview locations).
