<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Add & configure the "Multi-item Argument Order" sort

The module adds one Views sort, plugin id **`views_arg_order_sort_default`**, surfaced in the
UI as **"Multi-item Argument Order"** (group *Arguments*). It is a `#global` handler, so it
needs no relationship/join. There is **no admin settings page** (`configure: null`) — configure
it per view.

## Options

| Option | Type | Default | Meaning |
|---|---|---|---|
| `argument_number` | int | `0` | Which contextual filter to read the ordered values from (0 = first). In the UI shown as an "Argument" select. |
| `inherit_type` | bool | `TRUE` | Derive the sort column (table + field) from the chosen contextual filter's own handler. Leave on for the normal case. |
| `field_type` | string | `node::nid` | Explicit `table::field` to sort on. Used **only when `inherit_type` is off** (e.g. the argument is the NULL/none argument). |
| `null_below` | bool | `TRUE` | Put rows whose value is not in the argument list at the end. |
| `order` | string | (core) `ASC` | Standard sort direction; `DESC` reverses the argument sequence. |

## Via the Views UI

1. The view must already have a **contextual filter** (argument) whose values you pass, e.g.
   *Content: ID*.
2. Add **Sort criteria → "Multi-item Argument Order"**.
3. Set **Argument** to the contextual filter position, choose **Inherit type of Field from
   Argument** (recommended) or uncheck it and pick a **Type of Argument Field** (`table::field`),
   set **Non arguments at End** as desired, and pick ASC/DESC.
4. Save.
5. Pass the ordered values into the argument (usually via code — `$view->args`, a URL, or a
   REST/embed call). Values may be `+`- or `,`-separated.

## Where it is stored (view config entity)

`views.view.<id>` → `display.<display>.display_options.sorts.<sort_id>`:

```yaml
sorts:
  views_arg_order_sort:
    id: views_arg_order_sort
    table: views_arg_order_sort
    field: weight
    plugin_id: views_arg_order_sort_default
    order: ASC
    argument_number: 0
    inherit_type: true
    field_type: 'node::nid'
    null_below: true
```

## Scriptable (drush php:eval)

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = $view->get('display');
$display['default']['display_options']['sorts']['views_arg_order_sort'] = [
  'id' => 'views_arg_order_sort', 'table' => 'views_arg_order_sort', 'field' => 'weight',
  'plugin_id' => 'views_arg_order_sort_default', 'order' => 'ASC',
  'argument_number' => 0, 'inherit_type' => TRUE, 'field_type' => 'node::nid', 'null_below' => TRUE,
];
$view->set('display', $display)->save();
```

Read back: `drush cget views.view.my_view display.default.display_options.sorts.views_arg_order_sort`.

## How the query is built (`ArgOrderSort::query()`)

- Resolves the sort column: if `inherit_type`, from `$this->view->argument[argument_number]`'s
  `tableAlias`/`realField`; else from `explode('::', field_type)`.
- Reads `$this->view->args[argument_number]`, splits on `+` or `,`, reverses the list if
  `order === 'DESC'`.
- Emits `ORDER BY CASE <table>.<field> WHEN <val0> THEN 0 WHEN <val1> THEN 1 … ELSE <null_o>
  END` where `<null_o>` is `-1` or `max+1` depending on `null_below` and direction — so rows
  land in exactly the argument order, with non-matching rows first or last.

## Config schema

`config/schema/views_arg_order_sort.sort.schema.yml` defines
`views.sort.views_arg_order_sort_default` (extends `views_sort`) with `inherit_type` (bool),
`null_below` (bool), `argument_number` (int), `field_type` (string).
