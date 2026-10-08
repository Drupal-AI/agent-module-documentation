<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date/Time Format Help (date_format_help) — agent index

Adds an inline PHP `date()` format cheat-sheet to core's **Add date format** admin form
(`/admin/config/regional/date-time/formats/add`). Package `Date/Time`. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.0. **No dependencies, no config, no permissions, no routes,
no services, no Drush, no stored data.**

- **How it hooks the form, the render element, the format tables, and how to operate it** →
  [render/element.md](render/element.md)

## What it actually is (from source)

- `date_format_help.module` — two hooks:
  - `date_format_help_form_date_format_add_form_alter()`: appends `$form['date_format_help'] =
    ['#type' => 'date_format_help', '#weight' => 101]` and overrides
    `$form['date_format_pattern']['#description']` with a PHP-manual link.
  - `date_format_help_theme()`: registers a `date_format_help` theme entry (variables: none).
- `src/Element/DateFormatHelp.php` — a render element plugin `#[RenderElement('date_format_help')]`
  (`DateFormatHelp extends RenderElementBase`). Its `getInfo()` sets a `#pre_render` callback
  `preRenderDateFormHelp()` that builds two grouped sets of `#theme => 'table'` render arrays from
  the static `dateFormats()` and `timeFormats()` methods, one row per format char =
  `[char, description, date(char)]`, and attaches library `date_format_help/date_format_add`.
- `date_format_help.libraries.yml` — library `date_format_add` loads `css/date_format_help.css`
  (a two-column float layout for `.date-time-formatter-help-block`).

## Notes

- Descriptions are static translatable strings copied from the PHP manual (README credits the PHP
  Group, CC-BY-3.0). The only dynamic value is `date($char)` on the current **server** time — no
  request input is read or rendered.
- It provides a core render element (`#type`), not a new plugin type or a manager.
