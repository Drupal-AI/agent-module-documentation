<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The side-by-side report

Single page: `admin/reports/translate_side_by_side` (route `translate_side_by_side.admin`, access
`administer site configuration`). Implemented by `Drupal\translate_side_by_side\Form\SettingsForm`
(service `translate_side_by_side.settingsservice`). It is a **display/reporting** form — the
persistent submit button is removed; a **Load** button rebuilds the tables on demand.

## Form options (`buildForm`)

| Field | Type | Effect |
|---|---|---|
| Source language | `language_select` (configurable) | Column 1 values; defaults to site default language. |
| Target language | `language_select` (configurable) | Column 2 values; defaults to site default language. |
| Content types | multi-select (if `node` enabled) | Restrict the Nodes section to chosen types. |
| Skip field, if empty in source | checkbox | Omit rows whose source value is empty. |
| Fill untranslated with source | checkbox | Show the source value in the target column when no translation exists. |
| Load | button | Rebuilds the report with the selected options. |

## Sections rendered (each gated by its module being enabled)

- **Menus** — `menu_link_content` via the menu link tree (`buildFormMenu`).
- **Nodes** — `node` (`buildFormEntity($form,…, 'node', 'title', 'nid')`), filtered by content type.
- **Blocks** — `block_content` (`buildFormEntity(…, 'block_content', 'info', 'id')`).
- **Taxonomy** — `taxonomy` terms per vocabulary (`buildFormTaxonomy`).

For each entity a table (`buildFormTable` / `buildFormRow`) lists, per field, in form-display order:
field name/label, the **source-language** value, and the **target-language** value. Supported field
kinds include string/text fields, image **alt/title**, file **description**, link **title**, and
fields nested inside **paragraphs** (`retrieveParagraphs`). Field values are emitted as `#markup`
(so they pass through core's admin XSS filtering) and this whole page is only reachable by an
`administer site configuration` admin.

## Notes

- Read-only: nothing is written back; use it to plan/review translations, not to edit them.
- Entity queries here use `accessCheck(FALSE)` to list all content for the translator view —
  appropriate because the page itself is restricted to trusted admins.
- No config schema, permissions, plugins, or Drush commands are provided by this module.
