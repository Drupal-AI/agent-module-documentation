<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules

## custom_elements_ui

User interface for configuring Custom Elements Displays. Depends on `custom_elements` and
`field_ui`. Adds a "Manage custom element" Field-UI tab (`…/ce-display[/{view_mode}]`), the
`EntityCustomElementsDisplayEditForm`, dynamic per-entity-type permissions
(`administer <type> custom element display`), and the `_custom_elements_ui_view_mode_access` check.
Full detail in `config/displays.md`. Auto-installed on upgrade by `custom_elements_update_8303` if
present. This is the only project component that defines permissions.

## custom_elements_thunder

"Custom Elements Thunder Integration" — provides custom-elements output for **Thunder** paragraph
and media types. Depends on `custom_elements` only. In 3.x it ships **no processors**; instead it
installs `entity_ce_display` **config** (`config/install/custom_elements.entity_ce_display.*.yml`)
for media/paragraph types: `image`, `gallery`, `twitter`, `text`, `quote`, `link`. The 2.x
processors (and the old video/instagram/pinterest handling) were dropped — see the submodule
README for the non-seamless upgrade path (`drush config:import --partial`). Package: Thunder.

## custom_elements_extra_formatters

"Custom Elements Extra Formatters" — extra field formatters for third-party field types. Ships the
**`ce_tablefield`** formatter (`TableFieldCeFormatter`) for the `tablefield` field type: outputs
the table data as a structured array (`caption`, sorted `value` rows, `settings.row_header` /
`settings.column_header`), JSON-encoded when configured as a slot. No dependency on the tablefield
module is declared in info.yml (the formatter simply targets that field type when present).
Package: Custom Elements.

## Test-only module

`tests/modules/custom_elements_test_paragraphs` — a test fixture (article node type, paragraph and
media types, fields). Not for production use.
