# Webform Query — the `webform_query` service

`\Drupal\webform_query\WebformQuery`, constructed with `@database`. Fluent builder; instances are
single-use (state is cleared inside `processQuery()`). Get it fresh per query:

```php
$query = \Drupal::service('webform_query');
```

## Methods

| Method | Signature | Notes |
|---|---|---|
| `addCondition` | `($field, $value = NULL, $operator = '=', $table = 'webform_submission_data')` | Adds an AND condition. Default table is the EAV data table (matches `name = $field` AND `value <op> $value`). Other tables match `$table.$field <op> $value`. Array `$value` → `IN (...)`. |
| `setWebform` | `($webform_id = NULL)` | Shortcut for `addCondition('webform_id', $id, '=', 'webform_submission')`. |
| `orderBy` | `($field, $direction = 'ASC', $table = 'webform_submission_data')` | Adds ORDER BY via a correlated subselect on `sid`. Any direction other than `'ASC'` becomes `DESC`. |
| `addMinMax` | `($function, $table = 'webform_submission', $group_by = '', $condition = [])` | Adds `sid IN (SELECT MIN|MAX(sid) FROM $table [WHERE …] [GROUP BY $group_by])`. `$function` other than `'MIN'` becomes `MAX`. `$condition` = `[field, operator, value]`. |
| `buildQuery` | `()` | Returns `['query' => …, 'values' => …]`. Called internally. |
| `execute` | `()` | Runs the query and returns `fetchAll()` — array of `stdClass`, each with one `sid` property. |
| `processQuery` | `()` | Runs the query and returns the `Drupal\Core\Database\StatementInterface` (use `->fetchCol()`, etc.). Clears builder state. |
| `validateOperator` | `($operator)` | Rejects operators containing `UNION` or any of `[-'"();` (triggers `E_USER_ERROR`, returns `''`). |

## Examples

```php
// event_registration submissions for event 1 where age >= 18:
$rows = \Drupal::service('webform_query')
  ->setWebform('event_registration')
  ->addCondition('event', 1)
  ->addCondition('age', 18, '>=')
  ->execute();                       // [ {sid: 3}, {sid: 7}, ... ]

// filter by base-field uid, sorted, as a flat array of sids:
$sids = \Drupal::service('webform_query')
  ->addCondition('event', 1)
  ->addCondition('uid', 1, '=', 'webform_submission')
  ->orderBy('age', 'DESC')
  ->processQuery()->fetchCol();

// load the matching submissions:
$subs = \Drupal::entityTypeManager()->getStorage('webform_submission')->loadMultiple($sids);
```

## Caveats / grounding

- **No access control.** The service reads raw submission data with no permission or entity-access
  check — authorization and safe loading are the caller's responsibility. Do not expose its output to
  users who should not see submission data.
- **Trust your inputs.** Values are bound as placeholders and operators are blocklist-validated, but
  `orderBy()` field names and `addMinMax()` condition parts (`$condition[0]`, `$condition[2]`) are
  interpolated into SQL after only `escapeTable()`/no cleaning. Pass only developer-controlled field
  names here — never raw request input.
- Field/table identifiers are cleaned with `Connection::escapeTable()`, which strips non-alphanumeric/`_`
  characters, so exotic field machine names may not match.
