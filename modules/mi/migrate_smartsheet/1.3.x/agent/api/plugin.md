<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Smartsheet process plugin

Source rows must expose the Smartsheet `cells` array (via a migrate_plus source). Then map per column:

```yaml
process:
  title:
    plugin: smartsheet
    source: cell_array      # the row's cells array
    column_id: 123456789    # Smartsheet columnId to match
    return_key: 'value'     # cell key to return (e.g. value / displayValue)
```

Conditional form:

```yaml
  field_flag:
    plugin: smartsheet
    source: cell_array
    column_id: 123456789
    return_key: 'value'
    compare_value: 'Done'
    return_true_value: 1
    return_false_value: 0
```

`transform()` (`src/Plugin/migrate/process/Smartsheet.php`) matches `value['columnId'] == column_id`; throws `MigrateException` if the value is not traversable or `column_id` is unset.
