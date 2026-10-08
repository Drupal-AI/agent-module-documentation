<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (filters, scope logic, empty detection)

Two filter plugins under `src/Plugin/Filter/`, one shared service, one form-validation hook.
Both filters early-return unless the text contains `<th`.

## `TableHeaderScopeAttribute` (id `table_header_scope_attribute`)

`process()` loads the HTML with `Html::load()` + `\DOMXPath` and iterates `//table`:

- Only acts on a table that has at least one `<td>` (pure-`<th>` layout tables are left alone).
- Per row (`.//tr`): `belongs_to = 'row'` if the row contains a `<td>`, else `'col'`.
  (So a header-only row → column headers; a row mixing `<th>` + `<td>` → row headers.)
- Per `<th>` in the row:
  - skip if it already has a `scope` attribute;
  - skip if the validator says it is empty;
  - `scope = ($th->getAttribute($belongs_to.'span') > 1) ? $belongs_to.'group' : $belongs_to`
    — i.e. `col`, `row`, or `colgroup`/`rowgroup` when `colspan`/`rowspan` > 1.
- Serializes back with `Html::serialize()`.

## `EmptyTableHeaderToTableData` (id `table_header_scope_attribute_empty_th_to_td`)

`process()` iterates `//table//th`; for each one the validator considers empty it builds a new
`<td>`, clones the `<th>`'s child nodes and copies its attributes **except `scope`** (invalid
on `<td>`), then replaces the `<th>` with the `<td>`.

## `HtmlElementValidator` service (`table_header_scope_attribute.html_element_validator`)

`isElementContentEmpty(\DOMElement): bool`. Walks child nodes:

- Element child that is a **void element** (`img`, `br`, `input`, `hr`, …) ⇒ NOT empty.
- Other element child ⇒ recurse (e.g. an empty `<span>` is still empty).
- Text child ⇒ trim, decode entities, then strip all Unicode whitespace
  (`\s`, `\x{00A0}`, `\x{200B}`, `\x{FEFF}`, …); anything left ⇒ NOT empty.
- Comments / CDATA / PIs are ignored (treated as decorative → still empty).

Both filter plugins receive this service via `ContainerFactoryPluginInterface::create()`.

## Order enforcement — `Hook\TableHeaderScopeAttributeHooks`

Uses `#[Hook('form_filter_format_add_form_alter')]` / `#[Hook('form_filter_format_edit_form_alter')]`
to append a validate handler. When **both** filters are enabled it errors unless the empty-to-td
filter's weight is **greater than** the scope filter's weight (scope must run first). Also
provides `#[Hook('help')]` for the module help page.

## No extension surface

No `*.api.php`, no config schema, no config entity, no permissions, no Drush, and it defines no
new plugin *type* — it only implements core's `filter` plugin type. To reuse the emptiness logic
elsewhere, inject the `table_header_scope_attribute.html_element_validator` service.
