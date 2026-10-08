<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `#type => 'element_multiple'` — property & value reference

Plugin: `#[FormElement('element_multiple')]`,
`Drupal\element_multiple\Element\ElementMultiple` extends `FormElementBase`
(`src/Element/ElementMultiple.php`). `#input => TRUE`. Renders inside a `form_element`
theme wrapper as a `<table>` of rows plus add-more controls, wrapped in an AJAX `<div>`
whose id is `implode('_', #parents) . '_table'`.

## The repeated input: `#element`
- **Single mode (default):** `#element` is one render element. Default is
  `['#type' => 'textfield', '#title' => 'Item value', '#placeholder' => 'Enter value…']`.
  Set `#element => ['#type' => 'email', ...]`, `datelist`, etc. for a single-column list.
- **Composite mode:** `#element` is an associative array of named sub-elements
  (`'first_name' => [...], 'last_name' => [...]`) → each row is a table of columns. Sub-elements
  may nest (e.g. a `container` with children); nested inputs are flattened into the item.
- A sub-element of `#type => 'value'` (or otherwise non-visible) is carried per row as a hidden
  value that still lands in the returned item — useful for a stable per-row id.

## All properties (from `getInfo()`)
| Property | Default | Meaning |
|---|---|---|
| `#element` | textfield | The element (single) or associative array of elements (composite) repeated per row. |
| `#header` | NULL | `TRUE` = auto header from sub-element titles; array = explicit column headers (`['data'=>…, 'width'=>…]`); string = single spanning header; `FALSE` = no header. |
| `#header_label` | '' | Label used for the (single) header cell when `#header` is empty/omitted. |
| `#key` | NULL | Name of the sub-element whose value becomes the associative **array key** of each item (validated unique; also restores `#disabled` values, see below). |
| `#cardinality` | FALSE | Max item count. `FALSE` or `-1` (`CARDINALITY_UNLIMITED`) = unlimited. When reached, add controls are hidden and count is capped. |
| `#min_items` | NULL | Minimum rows shown. If unset: `0` normally, `1` when `#required`. Never below-min on remove. |
| `#empty_items` | 1 | Number of blank rows shown when there are no default values (0 when defaults meet min and a sub-element is required). |
| `#add_more` | TRUE | Show the "Add" button + numeric count below the table. |
| `#add_more_items` | 1 | Default value of the "add N" numeric input. |
| `#add_more_button_label` | 'Add' | Label of the add-more submit button. |
| `#add_more_input` | TRUE | Show the numeric count input beside the add button. |
| `#add_more_input_label` | 'more items' | Suffix/label for the numeric count input. |
| `#sorting` | TRUE | Drag-and-drop weight column (tabledrag, `element-multiple-sort-weight`); items are weight-sorted on submit. |
| `#operations` | TRUE | Show the per-row operations column. |
| `#add` | TRUE | Per-row "+" image button (insert a row after this one). |
| `#remove` | TRUE | Per-row "−" image button (remove this row). |
| `#item_label` | 'item' | Singular noun used in operation titles / messages. |
| `#no_items_message` | 'No items entered…' | Status message shown when the table has no rows. |
| `#ajax_attributes` | [] | Extra HTML attributes on the AJAX wrapper `<div>`. |
| `#table_attributes` | [] | HTML attributes on the `<table>`. |
| `#table_wrapper_attributes` | [] | HTML attributes on the table-wrapper `<div>`. |
| `#default_value` | (via valueCallback) | List of items (or keyed map when `#key`); a scalar is wrapped to a 1-item list. |

Standard FAPI properties also apply: `#title`, `#title_display`, `#required`, `#required_error`,
`#access`, `#states` (moved to a `js-form-wrapper` div and rewritten per-row so selectors resolve).

## Value / return structure
Produced by `valueCallback()` → `convertValuesToItems()`:
- Rows are collected from `#value['items']`, weight-sorted when `#sorting`, then each converted
  to an item. **Empty items are skipped** (`isEmpty()`: empty string / all-empty array).
- **Single mode** → item is the scalar value; result is a sequential array `[0 => 'a', 1 => 'b']`.
- **Composite mode** → item is an associative array of the sub-element values
  (`['first_name' => 'John', 'last_name' => 'Smith']`).
- **`#key` set** → the named sub-element's value is pulled out and used as the item key:
  `['john' => ['first_name' => 'John', ...]]`; duplicate keys raise a unique-key validation error.
- The final value is written with `setValueForElement()` in `validateElementMultiple()`, so the
  submit handler reads it via `$form_state->getValue('my_element')`.

## Internals worth knowing (for debugging)
- Row count is stored in `$form_state` under `element_multiple__{#name}__number_of_items`; an
  `__action` flag suppresses default values during an add/remove rebuild.
- `addItemsSubmit` / `addItemSubmit` / `removeItemSubmit` mutate the count + user input and call
  `$form_state->setRebuild()`; `ajaxCallback()` returns the element using only the AJAX
  prefix/suffix wrapper. Remove is guarded by `#min_items`.
- `addItemsSubmit` re-clamps the requested count against `#cardinality` server-side (a crafted
  POST cannot exceed cardinality even though the numeric input's `#max` is client-side only).
- `#disabled` sub-elements are not submitted by the browser; when `#key` is set,
  `restoreDisabledValues()` restores them by matching a hidden `_em_key_` mirror row (falling
  back to positional matching).
- Attaches library `element_multiple/element.element_multiple` (CSS/JS + `core/once`); `#states`
  usage additionally attaches `core/drupal.states`.
