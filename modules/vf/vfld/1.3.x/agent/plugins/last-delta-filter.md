# Views filter plugin `vfld` — `LastDeltaFilter`

Class: `Drupal\vfld\Plugin\views\filter\LastDeltaFilter`
(`src/Plugin/views/filter/LastDeltaFilter.php`), `@ViewsFilter("vfld")`, extends
`FilterPluginBase`, implements `ContainerFactoryPluginInterface`. `create()` injects
`entity_type.manager` into `$this->entityTypeManager`.

## Behaviour / options

- `protected $alwaysMultiple = TRUE;` and `public $always_required = TRUE;` — the filter always
  applies as a multiple-safe, required handler.
- Value is a Yes/No toggle. `getValueOptions()` → `[0 => 'No', 1 => 'Yes']`; `defineOptions()` sets
  `value.default = 0`. `valueForm()` renders `#type` `radios` when configuring, `select` when exposed.
- Single operator, from `operators()`: `'='` → title **"Is last delta"**, `method` `opQuery`,
  `values` `1`, `query_operator` `=`. `operatorOptions()`/`adminSummary()` derive from it.
  `adminSummary()` returns `grouped` for a grouped filter, else `"= No"` / `"= Yes"`.
- `defaultExposeOptions()` sets the exposed default label to `True` and `required = TRUE`.
- Config schema: `views.filter.vfld` — single integer `value`.

## The query it builds (`query()`)

Runs only when `$this->value` is truthy (value = **Yes**); otherwise it returns and the view is
unfiltered. Then:

```php
$this->ensureMyTable();
$field = $database->escapeField("$this->tableAlias.delta");
$query_base_table = $this->relationship ?: $this->view->storage->get('base_table');
$entity_type = $this->entityTypeManager->getDefinition($this->getEntityType());
$keys = $entity_type->getKeys();
$data = Views::viewsData()->get($this->table);
$join_info = $data['table']['join'][$query_base_table];
$join_info_field = $join_info['field'];
$query_base_table_id = $query_base_table . '.' . $keys['id'];

$subquery = \Drupal::database()->select($this->tableAlias, 'subquery');
$subquery->addExpression("MAX(subquery.delta)");
$subquery->where("subquery.$join_info_field = $query_base_table_id");

$or_condition = $this->query->getConnection()->condition('OR');
$or_condition->condition($field, $subquery, 'IN');
$or_condition->isNull($field);
$this->query->addWhere($this->options['group'], $or_condition);
```

Net SQL: `WHERE (<alias>.delta IN (SELECT MAX(delta) FROM <field_table> WHERE <join_field> =
<base>.<id>)) OR (<alias>.delta IS NULL)`. The correlated subquery picks the max delta **per base
entity**, so each row keeps only its own last value; the `IS NULL` arm preserves rows with no delta
(e.g. LEFT-joined empties). `field_name`/`entity_type` come from the `hook_views_data_alter`
definition (see [../hooks/views-data-alter.md](../hooks/views-data-alter.md)).

## Notes for agents

- All interpolated identifiers (`$this->tableAlias`, `$join_info_field`, base table, entity id key)
  originate from Views data / entity-type definitions and the view configuration, not from
  request/end-user input; the delta identifier is passed through `Connection::escapeField()`. The
  exposed filter value is only tested for truthiness — it is never concatenated into SQL.
- "Last delta" means highest `delta` (append order). If your field is not appended in chronological
  order, "last delta" is not "most recent" — verify the delta semantics for your data.
