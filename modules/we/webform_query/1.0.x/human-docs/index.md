# Webform Query — manual setup guide

**Webform Query** (`webform_query`) is a small **developer API** — a single
service — for finding Webform submission IDs that match conditions on submission
field values. It exists because Webform stores every field of every submission
in one EAV-style table (`webform_submission_data`), which makes "find submissions
where field A equals X *and* field B is at least Y" awkward with a plain query.
Webform Query builds that query for you, one correlated subquery per condition,
and hands back the matching submission IDs (`sid`).

You use it from custom code with a fluent builder: chain `addCondition()` calls
(with operators like `=`, `>=`, `LIKE`, or an array for `IN`), optionally scope
to one webform with `setWebform()`, add `orderBy()` or a `MIN`/`MAX` helper, then
call `execute()` for an array of results or `processQuery()` for the raw
statement (so you can `fetchCol()` the ids). You can also condition on the base
submission table's columns (like `uid` or `created`) by passing the table name as
a fourth argument.

There is **no UI, no configuration, no permissions, and no access checking** —
it is purely a building block for your own code, which is responsible for
authorizing the caller and loading the resulting submissions safely. Because it
has no admin surface, this guide folds the "how to use it" notes into this page.

This guide is written for a **human** (developer). If you want terse, token-cheap
references for an AI coding agent — including the full method table and caveats —
read the sibling [`agent/`](../agent/start.md) docs, especially
[`agent/api/query.md`](../agent/api/query.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Webform.

## How to use it

Get the service fresh for each query (instances are single-use), build your
conditions, and run it:

```php
// event_registration submissions for event 1 where age >= 18:
$rows = \Drupal::service('webform_query')
  ->setWebform('event_registration')
  ->addCondition('event', 1)
  ->addCondition('age', 18, '>=')
  ->execute();                       // [ {sid: 3}, {sid: 7}, ... ]

// filter by the base-table uid column, sorted, as a flat array of sids:
$sids = \Drupal::service('webform_query')
  ->addCondition('event', 1)
  ->addCondition('uid', 1, '=', 'webform_submission')
  ->orderBy('age', 'DESC')
  ->processQuery()->fetchCol();

// then load the matching submissions the normal way:
$subs = \Drupal::entityTypeManager()
  ->getStorage('webform_submission')
  ->loadMultiple($sids);
```

Key points:

- Conditions default to the `webform_submission_data` field table; pass a fourth
  argument to condition on any table with a `sid` column (e.g.
  `webform_submission` base fields such as `uid`, `created`).
- An array value generates an `IN (...)` match.
- `addMinMax('MIN'|'MAX', $table, $group_by)` finds the earliest/latest
  submission per group — handy for "first submission per user".

**Security:** the service reads raw submission data with no permission or
entity-access check, so never expose its output to users who should not see
submissions. Values are bound as query placeholders and operators are
blocklist-validated, but `orderBy()` field names and `addMinMax()` condition
parts are interpolated into SQL after minimal cleaning — pass only
developer-controlled field names there, never raw request input.

## Where it lives in the admin menu

Nowhere — Webform Query has no admin page. It is a service you call from PHP.
