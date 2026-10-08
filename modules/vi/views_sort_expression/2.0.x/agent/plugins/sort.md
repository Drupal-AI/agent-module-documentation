<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `views_sort_expression` Views sort handler

The whole module is: the plugin `src/Plugin/views/sort/ExpressionSort.php` and three hooks in
`views_sort_expression.module`. It plugs into core's existing `ViewsSort` plugin type — it does
**not** define a plugin type of its own.

## How the sort is exposed

`hook_views_data_alter()` registers a single global sort on the pseudo-table `views`:

```php
$data['views']['views_sort_expression'] = [
  'title' => t('Expression'),
  'help'  => t('Allow you to use an SQL expression.'),
  'sort'  => ['id' => 'views_sort_expression'],
];
```

So in the Views UI it appears under **Global → Expression** in "Add sort criteria" (not attached
to any field or entity). It can be added to any view display and can be exposed like any sort.

## Options (the config it stores)

`defineOptions()` adds two options on top of the base sort options; `buildOptionsForm()` renders them:

- **`expression`** — a `textarea`. Free-text SQL fragment used as the ORDER BY term. The form
  description states plainly: *"This is an advanced sort handler. You can use whatever is available
  on the SQL."* It links to the Views basic settings page and recommends enabling "Show the SQL query".
- **`aggregate`** — a `checkbox`, "Expression has an aggregate function". Set it when the expression
  uses an aggregate (SUM, COUNT, MAX, AVG, …).

Config schema (`config/schema/views_sort_expression.schema.yml`), type `views.sort.views_sort_expression`:
`expression` (string), `aggregate` (boolean).

## What the handler does at query time

```php
public function query() {
  if (!empty($this->options['expression'])) {
    $alias = $this->realField . '_' . $this->position;
    $this->query->addOrderBy(NULL, $this->options['expression'], $this->options['order'], $alias);
  }
}
```

Passing `NULL` as the table argument makes Views treat the second argument as a **formula**: the
expression string is placed into the ORDER BY clause as written, sorted by `$this->options['order']`
(ASC or DESC). The alias is `<realField>_<position>` (e.g. `views_sort_expression_1`). An empty
expression adds nothing.

Because the expression is inserted verbatim, whatever it references (a column, an alias, a joined
field, a function) **must already exist in the compiled query**. Adding a Views field does not
guarantee it reaches the SQL; the module's help suggests adding the field/sort you need elsewhere
in the view first, then referencing its real alias here. Turn on "Show the SQL query" (Views
settings, `/admin/structure/views/settings`) to discover the actual aliases.

## GROUP BY / aggregate handling

`usesGroupBy()` returns `FALSE`, so this sort itself never forces a GROUP BY. When the **aggregate**
option is on, `hook_views_post_build()` removes this sort's alias from the query's GROUP BY:

```php
function views_sort_expression_views_post_build(ViewExecutable $view) {
  foreach ($view->sort as $handler) {
    if ($handler instanceof ExpressionSort && $handler->options['aggregate']) {
      $alias = $handler->realField . '_' . $handler->position;
      $group_by =& $view->build_info['query']->getGroupBy();
      unset($group_by[$alias]);
    }
  }
}
```

This lets an aggregate expression (e.g. `SUM(field_amount)`) be used in ORDER BY without Views'
aggregation plugins fighting it — the sort alias is not added as a GROUP BY column.

## Adding it to a view in config (scriptable)

A sort entry in a display's `display_options.sorts` looks like:

```yaml
sorts:
  views_sort_expression:
    id: views_sort_expression
    table: views
    field: views_sort_expression
    plugin_id: views_sort_expression
    order: ASC
    expression: 'field_price IS NULL, field_price'
    aggregate: false
    relationship: none
    exposed: false
```

Load the `view` config entity, set the display's `sorts`, save; or add "Global → Expression"
through the Views UI, fill the Expression textarea, and (if needed) tick the aggregate checkbox.
Adding/editing a sort requires the `administer views` permission.
