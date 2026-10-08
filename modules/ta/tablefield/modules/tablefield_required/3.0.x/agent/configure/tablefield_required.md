# Configure required rows/columns

TableField required has **no dedicated admin page**. It extends the **field config edit form**
of any `tablefield` field (`hook_form_field_config_edit_form_alter` in
`tablefield_required.module`) with a "Tablefield required settings" details section. Values are
saved as **field third-party settings** under the `tablefield_required` namespace via an
`#entity_builders` callback (`tablefield_required_form_builder`).

## Where to set it

Structure → (entity) → Manage fields → your Table field → **Edit** (field settings). The
"Tablefield required settings" section is `#open` and is **only visible while the standard
"Required field" checkbox is unchecked** (`#states`). Use core's Required checkbox when you
want the *whole* field required; use this section to require only certain rows/columns.

## Settings (field third-party settings, namespace `tablefield_required`)

Schema: `config/schema/tablefield_required.schema.yml` (`field.field.*.*.*.third_party.tablefield_required`).

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `required_rows` | string | `''` | Comma-separated, **zero-based** row indexes to require (e.g. `0,2` = first & third rows). Whitespace is stripped. |
| `required_cols` | string | `''` | Comma-separated, **zero-based** column indexes to require (e.g. `0` = first column). Whitespace is stripped. |
| `multivalue_inherit` | boolean | `false` | If on, apply the same required rows/cols to **every** table of a multi-value field; if off, only the first table (delta 0) is validated. |

A cell is made required if its row index is in `required_rows` **or** its column index is in
`required_cols` (`tablefield_required_cell_is_required()`).

## How the requirement is enforced

1. `hook_field_widget_tablefield_form_alter` copies the field's `tablefield_required`
   third-party settings onto the widget element as `#tablefield_required`.
2. `hook_element_info_alter` appends `tablefield_required_process_tablefield` to the
   `tablefield` render element's `#process`.
3. That process callback walks `$element['tablefield']['table']` and sets `#required = TRUE`
   on each cell input in a configured required row/column, so Drupal's normal form validation
   blocks an empty required cell.

**It is skipped when:**

- the element is already `#required` (the whole field is required), or
- you are on the field-config path itself (`entity.field_config` routes), or
- it is a multi-value delta > 0 and `multivalue_inherit` is off.

## Notes

- No permission gates this; anyone who can edit the field settings can set required rows/cols.
- Rules live in the field's exported config (third-party settings), so they deploy with
  `drush config:export`.
- There is no config **object** and no settings route — hence `configure` is `null`.
