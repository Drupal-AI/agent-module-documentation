<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Many Selects (many_selects) — agent index

A single field widget that replaces the native `<select multiple>` with one **single** select
per value. On a multi-value field, core's multiple-value wrapper stacks one dropdown per delta
plus an "Add another item" button, so editors pick values one at a time instead of ctrl-clicking.
Widget-only: the field type and stored values are untouched, so switching it on/off is reversible
with no migration.

Key facts:
- **Widget** `many_options_select` ("Many select list"), class
  `OptionsManySelectWidget extends OptionsSelectWidget`. Field types: `entity_reference`,
  `list_integer`, `list_float`, `list_string`.
- Depends on core **Options**; needs Field UI to select it. PHP >= 8.1. Core `^10.2 || ^11`.
- **No routes, no permissions, no config entities, no config schema, no drush, and no new plugin
  types.** The only PHP is the widget, a `hook_help` provider (`src/Hook/ManySelectsHooks.php`,
  service `many_selects.hook_subscriber`), `many_selects.module` and `many_selects.services.yml`.
- One widget setting: `empty_label` (default `- None -`).
- Ships a `.tugboat/` config (upstream live-demo environment).

## What you'd do → where

- **Enable the widget, its field types, settings (`empty_label`), and how the single-select /
  `_none` behaviour works** → [fields/widget.md](fields/widget.md)

There is nothing else to configure — no admin UI, no permissions to grant, no API to call.
