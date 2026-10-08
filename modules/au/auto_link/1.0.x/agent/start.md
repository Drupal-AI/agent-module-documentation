<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Link Field Formatter (auto_link) — agent index

A single core **Field Formatter** plugin that renders plain-text fields with their URLs turned into
clickable `<a>` links. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.4.
Declares a dependency on core **`filter`** in `auto_link.info.yml` but does not use a filter plugin.

- **The formatter, its one setting, how it builds links, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `AutoLinkFormatter` (id **`auto_link_formatter`**, label *"Auto Link (Convert URLs to
  Links)"*) in `src/Plugin/Field/FieldFormatter/AutoLinkFormatter.php`, extending core
  `FormatterBase`. `field_types = { "string", "text_long", "text", "string_long" }`.
- **No** field type, **no** widget, **no** permissions, **no** routes, **no** services, **no** hooks,
  **no** Drush, **no** config schema and **no** config/install. Everything is configured per
  view-display on *Manage display* / Layout Builder.

## Mechanism (from source)

- `defaultSettings()` → `open_new_tab => TRUE`. `settingsForm()` exposes one checkbox *"Open links in
  new tab"*; `settingsSummary()` reports the choice.
- `viewElements()` iterates the items and, for each non-empty `$item->value`, runs a
  `preg_replace_callback` over `/(?<!["\'])(?<!\])\b(?:https?:\/\/|www\.)[^\s<]+/i`. The callback
  prefixes bare `www.` matches with `http://`, then returns
  `<a href="…" [target="_blank" ]rel="noopener noreferrer">…</a>` where both the href and the link
  text are passed through `htmlspecialchars(..., ENT_QUOTES, 'UTF-8')`. The result is run through
  `nl2br($text, FALSE)` and returned as the formatter's rendered `#markup`.

See [fields/formatter.md](fields/formatter.md) for the settings-export shape and operating notes.
