# Migrate Process Array — manual setup guide

**Migrate Process Array** (`migrate_process_array`) provides array‑centric Migrate
process plugins for the moments in a migration when a source value is a list and
you need to reshape or filter it. A common case: you have an array of values and
want to keep only the ones that match a known set, or drop the ones that appear in
a set you want to exclude.

The module ships two plugins for exactly that. **`array_intersect`** returns only
the source values that also appear in a `match` list, and **`array_diff`** returns
the source values that do *not* appear in an `exclude` list. Given
`['a', 'bunch', 'of', 'values']`, `array_intersect` with a match of `['values']`
returns `['values']`, while `array_diff` excluding `['values']` returns
`['a', 'bunch', 'of']`.

Migrate Process Array is part of a wider migration framework originally built for
a Digital Measures import, alongside sibling modules such as Migrate Process XML,
Regex, URL, Trim, and Skip — but it stands on its own and is generic enough for
any migration. It supports **Drupal 9.3, 10, and 11**. This is developer/CLI
migration infrastructure with no request‑time surface: you author the migration
and run it under Drush, and there is no admin screen to configure.

> **Security coverage:** this module's releases are **not covered** by Drupal's
> security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module. It has no settings form; you
use its plugins from migration YAML as described below.

## How to use it

Add the plugin to the process step for the array field you want to reshape:

```yaml
# Keep only the values that appear in the match list
field_of_array_values:
  plugin: array_intersect
  source: some_array_field
  match:
    - values
    - to
    - match

# Or: keep everything except the values in the exclude list
field_of_array_values:
  plugin: array_diff
  source: some_array_field
  exclude:
    - values
    - to
    - match
```

Point `source` at the field that holds the array, and list the values to match
against (for `array_intersect`) or exclude (for `array_diff`). The plugin returns
the filtered array, which you can then pass on to the rest of your process
pipeline.
