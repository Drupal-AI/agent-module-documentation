<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anti-Duplicates configuration

Install/enable: `drush en anti_duplicates` (only core `node` is required). Configure at
`admin/config/anti-duplicates` (route `anti_duplicates.admin_page`, permission
`administer anti_duplicates`, which is `restrict access: TRUE`). The menu link
(`anti_duplicates.links.menu.yml`) lives under Configuration › Content.

## Config object `anti_duplicates.settings`

Single config object, editable by `Drupal\anti_duplicates\Form\AntiDuplicatesAdminForm`
(`getEditableConfigNames()`). Defaults come from `config/install/anti_duplicates.settings.yml`;
types from `config/schema/anti_duplicates.schema.yml`. Both message keys are exposed to
Configuration Translation via `anti_duplicates.config_translation.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `anti_duplicates_message` | text_format (`value` + `format`) | "Existing content with a similar title…", `basic_html` | Introduction shown above the results, and only when matches are found. |
| `result_count_message` | text_format (`value` + `format`) | "Total: &lt;b&gt;@count&lt;/b&gt;", `basic_html` | Shown below the results; `@count` is replaced with the total number of matches. Empty = hidden. |
| `anti_duplicates_form_submission` | boolean | `false` | If true, the JS disables the form's submit buttons while results are listed until the author clicks "Not a duplicate" (passed to JS via `drupalSettings.anti_duplicates.disable_form`). |
| `anti_duplicates_ajax_events` | mapping (`keyup_debounced`, `blur` → string) | `{keyup_debounced: keyup_debounced, blur: blur}` | Which events trigger the search. The form alter imposes a `keyup_debounced` fallback if the stored list is empty. |
| `anti_duplicates_debounce_delay` | integer | `500` | Milliseconds to wait after the last keystroke before searching (only relevant when `keyup_debounced` is a trigger); min 100. Pushed to the title field as `data-delay`. |
| `anti_duplicates_search_type` | integer | `2` | Match strategy: `0` = wildcard sequence of keywords, `1` = exact title as substring, `2` = any single word. `#required` radios. |
| `search_result_limit` | integer | `5` | Max items listed (`range(0, limit)`); `0` = list all matches. The count message always reflects the full total. `#required`, min 0. |
| `anti_duplicates_content_types` | sequence of machine-name → machine-name | `{article: article, page: page}` | Content types the check applies to. Empty = **all** types (no restriction). A title is only compared with content of the same type. |
| `anti_duplicates_placement` | integer | `0` | `0` = results in the right sidebar (adds a `details` element to the `advanced` group); `1` = results directly under the title field. |

Note: the 4.2.x `anti_duplicates_display_not_zero` key no longer exists — `anti_duplicates_update_9003`
clears it. Results are only rendered when the count is at least 1.

## Settings form fields (`AntiDuplicatesAdminForm::buildForm`)

The form is split into three open `details` groups.

- **Search** (`buildSearchGroup`):
  - `anti_duplicates_content_types` — checkboxes; options built from `entity_type.manager` →
    `node_type` storage `loadMultiple()` (id → label).
  - `anti_duplicates_search_type` — radios (0/1/2), required.
  - `search_result_limit` — number (min 0, step 1), required.
- **Behavior** (`buildBehaviorGroup`):
  - `anti_duplicates_ajax_events` — checkboxes (`blur`, `keyup_debounced`), required.
  - `anti_duplicates_debounce_delay` — number (min 100, step 100, suffix "ms"); only visible when
    `keyup_debounced` is checked (`#states`).
  - `anti_duplicates_form_submission` — checkbox.
- **Display** (`buildDisplayGroup`):
  - `anti_duplicates_placement` — radios (0 sidebar / 1 under title).
  - `anti_duplicates_message` — `text_format` (3 rows).
  - `result_count_message` — `text_format` (3 rows).

`submitForm()` writes all keys back onto `anti_duplicates.settings` (casting booleans/integers and
`array_filter`-ing the checkbox maps) and shows a status message. The form injects `config.factory`,
`config.typed`, and `entity_type.manager` via `create()`.
