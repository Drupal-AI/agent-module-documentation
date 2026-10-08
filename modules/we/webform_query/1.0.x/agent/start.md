# Webform Query — agent index

A single developer service, `webform_query` (`\Drupal\webform_query\WebformQuery`), that returns
Webform submission IDs (`sid`) matching value conditions across the EAV `webform_submission_data`
table. No UI, config, permissions, plugins, or Drush. Depends on `webform:webform`.

- **The service: builder methods, return shapes, cross-table queries, examples, caveats** →
  [api/query.md](api/query.md)

Key facts:
- Base query is `SELECT sid FROM {webform_submission} ws`, plus one correlated `sid IN (SELECT …)`
  subquery per `addCondition()`.
- `execute()` → array of stdClass with one `sid` prop; `processQuery()` → `StatementInterface`.
- Conditions default to table `webform_submission_data`; pass a 4th arg to hit any `sid`-keyed table.
- Values are bound as placeholders; operators go through a `validateOperator()` blocklist; field/table
  names are `escapeTable()`-cleaned. No access control — the caller must authorize + load safely.
