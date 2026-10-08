Webform Query is a small developer API (a single service) that finds Webform submission IDs matching conditions on submission field values, working around the fact that Webform stores all submission data in one EAV-style table.

---

The module exposes one service, `webform_query` (`\Drupal\webform_query\WebformQuery`), with a fluent
builder. Because `webform_submission_data` stores every field as name/value rows, filtering by several
fields at once is awkward with a plain query; this service builds a `SELECT sid FROM webform_submission`
with one correlated `sid IN (SELECT …)` subquery per condition. You chain `addCondition($field, $value,
$operator, $table)`, optionally `setWebform($webform_id)`, `orderBy($field, $direction, $table)`, and
`addMinMax($function, $table, $group_by, $condition)`, then call `execute()` (returns an array of objects
each with a single `sid` property) or `processQuery()` (returns the `StatementInterface` so you can
`fetchCol()` etc.). Conditions default to the `webform_submission_data` table but can target any table
with a `sid` column (e.g. `webform_submission` base fields like `uid`, `created`) by passing the table
name as the 4th argument — those are evaluated first for performance. Values are bound as query
placeholders and operators are run through a `validateOperator()` blocklist; table and field names are
passed through `Connection::escapeTable()`. It has **no UI, config, permissions, or access checking** —
it is meant to be called from custom code, which is responsible for authorizing the caller and loading
the resulting submissions safely.

---

- Find all submissions of a webform where a field equals a value: `addCondition('event', 1)`.
- Combine multiple field conditions (AND) in one query, e.g. `event = 1` AND `age >= 18`.
- Scope a query to a single webform with `setWebform('event_registration')`.
- Query across all webforms by omitting `setWebform()`.
- Use comparison operators (`>=`, `<=`, `>`, `<`, `!=`, `LIKE`) on submission field values.
- Match a field against a list of values by passing an array (generates `IN (...)`).
- Filter on webform_submission base fields (uid, created, completed) via the 4th `table` argument.
- Return only submission IDs, then load the submissions the normal way with the storage handler.
- Sort results by a submission field value: `orderBy('age', 'DESC')`.
- Sort by a base-table column by passing its table name to `orderBy()`.
- Get the earliest/latest submission per group with `addMinMax('MIN'|'MAX', $table, $group_by)`.
- Retrieve the min/max submission ID grouped by `webform_id`.
- Fetch results as a flat column of sids via `processQuery()->fetchCol()`.
- Build a report of registrants for an event across submissions.
- Find submissions by a specific user by conditioning `uid` on the `webform_submission` table.
- Deduplicate or find "first submission per user" using the MIN/MAX helper with a group-by.
- Power a custom block/controller that lists submissions matching business rules.
- Feed matching sids into a batch operation (e.g. bulk email or export).
- Use as a building block inside a Drush command or cron job that processes submissions.
- Pre-filter on indexed base-table columns first (module orders those subqueries earlier) for speed.
