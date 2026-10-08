<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, enforcement & Interval math

## Where you configure it

Edit a comment type at `/admin/structure/comment/manage/{comment_type}` (core route
`entity.comment_type.edit_form`, permission **`administer comment types`**). The module's
`hook_form_comment_type_edit_form_alter` adds a **"Comment Limit Settings"** `details` group.

| Form field | `#type` | Stored third-party key | Default | Notes |
|---|---|---|---|---|
| Limit | number (min 1, required) | `limit` | `5` | Max allowed within the window. |
| Interval Number | number (min 1, required) | `interval_number` | `1` | Window length count. |
| Interval Unit | select (required) | `interval_unit` | `hour` | Options: hour/day/week/month. |
| Fields | select `#multiple` (required) | `fields` | `[]` | Comment field machine names, minus `cid`/`uuid`/`comment_type`. |

Values are persisted by the `#entity_builders` callback
`comment_submissions_limit_comment_form_builder`, which calls
`$comment_type->setThirdPartySetting('comment_submissions_limit', …)` for each. They live in the
comment type config entity (`comment.type.{id}.yml`) under
`third_party_settings.comment_submissions_limit`; schema in
`config/schema/comment_submissions_limit.schema.yml`.

Note: the interval-unit **select** offers only hour/day/week/month, while the `Interval` value
object also accepts `minute` and `year` — the extra two are only reachable programmatically.

## Enforcement (`comment_submissions_limit_comment_form_validate`)

Attached to every comment form via `hook_form_comment_form_alter` → `$form['#validate'][]`.
Runs server-side during comment form validation:

1. Loads the comment's `comment_type` entity and its four third-party settings (falling back to
   the same defaults: limit 5, interval 1, unit hour, fields []).
2. `$expiration_date = (new Interval($interval_number, $interval_unit))->subtract(new DrupalDateTime('now'))`.
3. Builds a comment entity query:
   - `->accessCheck()` (access-checked count),
   - `->condition('comment_type', $comment_type->id())`,
   - `->condition('created', $expiration_date->getTimestamp(), '>')`,
   - for each selected field: `->condition($field_name, $field_value)` where `$field_value` is the
     submitted value (`$form_state->getValue($field_name)`, taking `[0]['value']` when it's an array).
4. `->range(0, $limit)->count()->execute()` — count is capped at `limit`.
5. If `$comment_count == $limit`, sets `t('You have reached the comment limit of @limit comments in
   the last @interval.', …)` as a form error **on each selected field**. `@interval` is
   `Interval::__toString()` = `"{number} {unit}"`.

The limit is therefore scoped to **(comment type) × (the exact submitted values of the selected
fields) × (rolling time window)**. Which "identity" it throttles depends entirely on which fields
you pick — e.g. selecting an author/mail-style field approximates per-user, selecting the subject
field throttles per identical subject, etc. All conditions are parameterized entity-query
conditions (no raw SQL); the message uses `t()` placeholders (auto-escaped).

## `Interval::subtract()` month clamp

`subtract()` clones the date and applies `modify('-{number} {unit}')`. For `month`, if the day of
month changed (e.g. subtracting a month from Mar 31 would roll to Mar 3), it snaps to
`last day of previous month` so "Mar 31 − 1 month" = Feb 28/29.
