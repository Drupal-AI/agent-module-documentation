<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Select Other field

## Prerequisites
- Enable `cck_select_other` (depends on core `options`, which it pulls in).
- Have (or create) a **List** field: `list_string`, `list_integer`, or `list_float`. Not
  `list_boolean`. Define its **Allowed values** as normal.

## Set the widget
On the entity's **Manage form display** (e.g. `admin/structure/types/manage/<bundle>/form-display`):
1. Set the field's widget to **"Select other list"** (`cck_select_other`).
2. In the widget settings gear, optionally change **Other label** (default "Other"). The label is
   HTML-escaped and stripped of tags before display.

The rendered element is a `<select>` containing: an optional empty option (`- None -` for optional
fields, `- Select a value -` for required), each allowed value, and an **`other`** option. Picking
`other` reveals a text field (`js/widget.js`, jQuery `change` handler). With JS off the textfield is
simply always visible.

## Set the formatter (optional)
On **Manage display**, choose the **"Select other"** formatter (`cck_select_other`) to render values.
It looks each stored value up in the field's `allowed_values` and prints the human label; for an
off-list ("other") value it prints the stored value itself. Both go through `FieldFilteredMarkup`.
The core "List" formatters also work but will show the raw key for off-list values.

## Views filter (optional)
When a field uses this widget on a form display, `hook_views_data_alter` swaps that field's Views
filter to `select_other`, which behaves like the core options list filter but adds the **"Other"**
option. Exposed, "Other" matches any stored value that is not one of the defined allowed values
(implemented in `opSimple()` as a NOT IN / IN against the known option set).

## How the value is stored and validated
- The submitted value is written **directly into the same list field's value column**. There is no
  separate storage for the "other" text.
- `SelectOtherWidget::validateElement()` (form level): required-empty select → error; `other` with
  empty text → error (required) or NULL (optional); a select value not in `#options` → "not a valid
  choice" error; otherwise the chosen key, or the "other" text, is stored.
- Field level: the module **replaces core's `AllowedValues` constraint plugin site-wide**
  (`hook_validation_constraint_alter` → `SelectOtherAllowedValuesConstraint` +
  `SelectOtherAllowedValuesConstraintValidator`). For a List field that has this widget on any form
  display, the validator adds the submitted value to the allowed choices, so **arbitrary values
  pass allowed-values validation on every write path** — forms, REST/JSON:API, migrations,
  programmatic saves. Fields without the widget keep core's validation (`validateFallback`).

## Design implications
- The field is **no longer a closed set**. Anything assuming the key is one of the configured
  allowed values (facets, custom queries, template `switch` on the key, access logic keyed on the
  value) must tolerate off-list values. If you must keep the list authoritative, capture the "other"
  text in a **second** dedicated text field instead of into the list field.
- Off-list values are **user-entered text**; escape them anywhere you render them outside the
  provided formatter.
- On `list_integer` / `list_float`, non-numeric "other" input is a storage/robustness hazard — use
  `list_string` when you expect arbitrary text.
- Known limitation (README): radio/checkbox variants are not supported; the widget is a select
  list. Multi-value fields are supported (one select+text per delta).
