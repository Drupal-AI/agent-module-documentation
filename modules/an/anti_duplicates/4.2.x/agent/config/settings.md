<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anti-Duplicates configuration

Install/enable: `drush en anti_duplicates` (only core `node` is required). Configure at
`admin/config/anti-duplicates` (route `anti_duplicates.admin_page`, permission
`administer anti_duplicates`, which is `restrict access: TRUE`). The menu link
(`anti_duplicates.links.menu.yml`) lives under Configuration › Content.

## Config object `anti_duplicates.settings`

Single config object, editable by `Drupal\anti_duplicates\Form\AntiDuplicatesAdminForm`
(`getEditableConfigNames()`). Defaults come from `config/install/anti_duplicates.settings.yml`;
types from `config/schema/anti_duplicates.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `anti_duplicates_message` | text_format (`value` + `format`) | empty, `basic_html` | Notice shown above the results panel. If `value` is empty, `anti_duplicates.module` falls back to a hardcoded default string. |
| `anti_duplicates_form_submission` | boolean | `false` | If true, the JS disables auto-submit until the author clicks the "Not a duplicate" link (value is passed to JS via `drupalSettings.anti_duplicates.disable_form`). |
| `anti_duplicates_search_type` | integer | `2` | Match strategy: `0` = wildcard sequence of keywords, `1` = exact title as substring, `2` = any single word. `#required` radios. |
| `anti_duplicates_content_types` | mapping of machine-name → machine-name | `{article: article, page: page}` | Content types the check applies to. Empty = **all** types (no restriction) in the form alter, but note the AJAX callback returns empty when the current type is not in this list — see [api/duplicate-search.md](../api/duplicate-search.md). |
| `anti_duplicates_placement` | integer | `0` | `0` = results in the right sidebar (adds a `details` element to the `advanced` group); `1` = results directly under the title field. |
| `anti_duplicates_display_not_zero` | integer | `0` | If truthy, still render the panel even when the count is 0; the callback also uses this to decide whether to short-circuit on a zero count. |

## Settings form fields (`AntiDuplicatesAdminForm::buildForm`)

- `anti_duplicates_message` — `text_format`.
- `anti_duplicates_form_submission` — checkbox.
- `anti_duplicates_search_type` — radios (0/1/2), required.
- `anti_duplicates_content_types` — checkboxes; options are built from
  `entity_type.manager` → `node_type` storage `loadMultiple()` (id → label).
- `anti_duplicates_placement` — radios (0 sidebar / 1 under title).
- `anti_duplicates_display_not_zero` — checkbox.

`submitForm()` writes all six keys straight back onto `anti_duplicates.settings` and shows a status
message. The form injects `config.factory`, `config.typed`, and `entity_type.manager` via `create()`.
