# Use the `dropdownlist` Views filter

There is no UI or settings page. The module only registers a Views filter plugin; you make a
filter use it by pointing that filter's handler at the `dropdownlist` plugin id.

## What it does
`DropdownList` extends core `InOperator`, so once selected the filter behaves like core
"is one of" (multi-value select, IN condition). The difference is where the options come from:

```php
// src/Plugin/views/filter/DropdownList.php
public function getValueOptions() {
  $values = $this->dbConnection->select($this->table, 'tbl')
    ->fields('tbl', [$this->realField])
    ->execute()
    ->fetchAllKeyed(0, 0);          // value => value
  foreach ($values as $k => $name) {
    $values[$k] = $this->t($name)->render();
  }
  $this->valueOptions = $values;
  return $this->valueOptions;
}
```

`$this->table` and `$this->realField` are the filter handler's own table/column (resolved by
Views from the handler definition). So the dropdown lists **every value currently stored** in
that column (not DISTINCT-reduced in SQL, but collapsed by the value=>value keying).

## Attaching it to a filter
The module ships no `hook_views_data` that assigns `dropdownlist` to any field, so choose one of:

1. **Edit the view config** — in the view's YAML, set the filter's plugin id:
   ```yaml
   display:
     default:
       display_options:
         filters:
           my_field:
             plugin_id: dropdownlist
             exposed: true
             # table:/field: as for the column you are filtering
   ```
2. **Provide views data** — in a custom module's `hook_views_data[_alter]`, set
   `$data[<table>][<field>]['filter']['id'] = 'dropdownlist';` for the column you want to expose
   as a populated dropdown.

Then expose the filter as usual; visitors get a select of the column's values.

## Caveats / behaviour
- Options reflect live data and are rebuilt each time the filter runs (a query per build).
- Values are passed through `t()`, so translatable string values get localised labels; opaque
  values (ids, codes) are shown verbatim.
- Best suited to columns with a bounded set of repeated values; a high-cardinality column would
  produce an unwieldy dropdown.
- `table`/`realField` derive from Views handler config (an `administer views` task), not from
  request parameters.
