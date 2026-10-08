<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ace Editor — agent index

Integrates the JS **Ace** code editor into Drupal through three core extension points. It
defines **no plugin types of its own**, has **no admin settings form**, and **no configure
route** (`configure: null`). Depends on core `editor`.

Three integration points:
- **Text-editor plugin** `ace_editor` — assign the Ace editor to a text format. Settings stored
  under `editor.editor.<format>` → `settings.fieldset.*`.
- **Field formatter** `ace_formatter` — read-only highlighted display of `text_long` /
  `text_with_summary` fields.
- **Text filter** `ace_filter` — `<ace>…</ace>` tags become highlighted snippets in body text.

Docs:
- **Wire Ace to a text format, set global defaults, install the JS library** →
  [configure/setup.md](configure/setup.md)
- **The `<ace>` filter tag and its per-tag attributes; the `ace_formatter`** →
  [api/filter-and-formatter.md](api/filter-and-formatter.md)

Key facts:
- Global defaults live in the config object **`ace_editor.settings`** (theme, syntax, height,
  width, font_size, line_numbers, show_invisibles, print_margins, auto_complete, use_wrap_mode,
  plus `theme_list`/`syntax_list` option maps). No UI — edit with `drush config:set`.
- Per-format editor settings are nested under a **`fieldset`** key:
  `editor.editor.<format>.settings.fieldset.theme` etc.
- The Ace **JavaScript library is not bundled** — download ajaxorg/ace-builds into `/libraries/ace`
  (or `/libraries/ace-builds`); `hook_requirements()` errors until present.
- The shipped `ace_editor.permission.yml` is **mis-named** (core reads `*.permissions.yml`), so
  `administer ace_editor` is **not** actually registered. There is no permissions doc.
