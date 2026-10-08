# FooTable — the `footable` render element

`src/Element/FooTable.php` (`@FormElement("footable")`) extends core's `Table` render element, so it
takes the same `#header` / `#rows` (and form-table `#tableselect` etc.) as a normal Drupal table, and
turns extra `#`-properties into the HTML5 `data-*` attributes the jQuery plugin reads. Use it in a
custom render array or form when you want a FooTable outside of Views.

## Behavior
- `getInfo()`: `#theme => footable`, adds `processFooTable` and `preRenderFooTable`, and seeds one
  `#<key>` per entry in `getProperties()` with its default.
- `processFooTable()`: unsets `#sticky` and `#responsive` (FooTable handles responsiveness itself).
- `preRenderFooTable()`: adds class `footable`, attaches the configured library
  (`footable.footable` service → `getLibrary()`, i.e. the standalone/bootstrap + minified/source
  build chosen in `footable.settings`), then for every property whose value differs from its default
  writes `data-<key> = value` (bools become `"true"`/`"false"`). For `#header` entries carrying a
  `footable` sub-array with `sort`, it sets table `data-sorting=true` and header
  `data-sortable/data-direction/data-breakpoints`.

## Properties (`#property` → `data-<key>`)
`empty` (`data-empty`, default "No Results"), `expand_all`→`expand-all`, `expand_first`→`expand-first`,
`show_header`→`show-header` (default F here), `show_toggle`→`show-toggle` (T), `toggle_column`→
`toggle-column` (`first`), `use_parent_width`→`use-parent-width`, `filtering`→`filtering`,
`filter_container`→`filter-form-container`, `filter_delay`→… (and the rest of the filtering/paging/
sorting/state keys, mirroring the Views style options). Only non-default values are emitted.

## Example
```php
$build['table'] = [
  '#type' => 'footable',
  '#header' => ['Name', 'Email', 'Phone'],
  '#rows' => $rows,
  '#filtering' => TRUE,
  '#paging' => TRUE,
  '#toggle_column' => 'first',
];
```
Requires the FooTable jQuery library installed in `/libraries/footable` (see configure/global.md).
