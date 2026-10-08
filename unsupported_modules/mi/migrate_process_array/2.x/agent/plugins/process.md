<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate process plugins

The module adds five **`MigrateProcessPlugin`** implementations to core's `migrate.process`
plugin type (it defines no plugin type / manager of its own). Each lives in
`src/Plugin/migrate/process/` and is used by `plugin:` id inside a migration's `process:`
pipeline. They all reshape/filter the value flowing through the pipeline; none touch the
database, the filesystem, or the network. Use them under Drush (`drush migrate:import`) like
any core process plugin.

Shared behaviour of the four custom plugins (`array_diff`, `array_intersect`, `array_filter`,
`deepen`): an **empty** incoming value (`empty($value)`) short-circuits to `NULL`, and a
**scalar** incoming value is coerced to a single-element array (`$value = [$value]`) before
processing. `array_diff`/`array_intersect` also return `NULL` when the result is empty, because
"Migrate treats NULL as empty, not empty arrays."

## `array_diff` — `ArrayDiff.php`

Returns the source array with the members of `exclude` removed (PHP `array_diff` family).

```yaml
field_of_array_values:
  plugin: array_diff
  source: some_array_field
  exclude:
    - values
    - to
    - match
```

Config keys:

| Key | Required | Meaning |
|---|---|---|
| `exclude` | yes | Array (or scalar, coerced) of values to remove. |
| `method` | no | `assoc` → `array_diff_assoc`; `key` → `array_diff_key`; `uassoc` → `array_diff_uassoc` (needs `callable`); `ukey` → `array_diff_ukey` (uses `callable`); anything else / omitted → plain `array_diff`. |
| `callable` | for `uassoc`/`ukey` | User comparison callback. |

Note: the `uassoc` branch guards `!empty($callable)`, but the **`ukey` branch does not** — using
`method: ukey` without a `callable` passes `NULL` to `array_diff_ukey()` and raises a PHP
`TypeError` at migrate time. Supply a `callable` whenever you use `ukey`.

## `array_intersect` — `ArrayIntersect.php`

Mirror of `array_diff`: returns only the source members that also appear in `match` (PHP
`array_intersect` family).

```yaml
field_of_array_values:
  plugin: array_intersect
  source: some_array_field
  match:
    - values
    - to
    - match
```

Config keys: `match` (required), plus the same `method` (`assoc`/`key`/`uassoc`/`ukey`/default)
and `callable` semantics as `array_diff` — mapping to `array_intersect_assoc`,
`array_intersect_key`, `array_intersect_uassoc`, `array_intersect_ukey`, or plain
`array_intersect`. The same missing-`callable` caveat on `ukey` applies.

## `array_filter` — `ArrayFilter.php`

Runs PHP `array_filter` over the source array. With no `callable`, drops falsy members
(`array_filter($value)`); with a `callable`, uses it as the filter callback.

```yaml
field_of_array_values:
  plugin: array_filter
  source: some_array_field
  callable: 'my_function'
# or a static method:
  callable:
    - '\Drupal\my_module\MyClass'
    - myMethod
```

`callable` works like core's `callback` process plugin's `callable`. Unlike `array_diff`/
`array_intersect`, an empty result is returned as-is (an empty array), not converted to `NULL`.

## `deepen` — `Deepen.php`

The opposite of "flatten": wraps **each** source member in its own single-element array, so a
flat list becomes a list of deltas suitable for a multi-value field or `sub_process`.

```yaml
field_media:
  -
    source: the_source
    plugin: deepen
    key: 'target_id'
  -
    plugin: sub_process
    process:
      target_id: target_id
```

- Without `key`: `['123','456']` → `[['123'], ['456']]` (numeric `0` keys).
- With `key: 'target_id'`: `['123','456']` → `[['target_id'=>'123'], ['target_id'=>'456']]`.

Config keys: `key` (optional) — the associative key to assign each wrapped value.

## `extract_single` — `ExtractSingle.php`

Subclass of core's `Drupal\migrate\Plugin\migrate\process\Extract` with **no code changes** — it
only re-registers the plugin so it runs **per field value (delta)** instead of once over the
whole multi-value array. Use it to pull the same sub-key out of every delta:

```yaml
my_field:
  source: some_field   # e.g. [ ['my_key'=>'A'], ['my_key'=>'B'] ]
  plugin: extract_single
  index:
    - my_key           # → 'A' for delta 0, 'B' for delta 1
```

Config keys are inherited from core `Extract`: `index` (required — array of nested keys via
`NestedArray::getValue`) and `default` (optional — value returned when the index is missing;
without it a missing index throws `MigrateException`).

How the per-delta behaviour works (and a source quirk): core `Extract` is registered with the
attribute `#[MigrateProcess(id: "extract", handle_multiples: TRUE)]`, so it is called once on the
whole array. `ExtractSingle` instead declares the **legacy** annotation
`@MigrateProcessPlugin(id = "extract_single", handle_mulitples = FALSE)`. The key is **misspelled**
(`handle_mulitples`) and is therefore ignored — but the intended value `FALSE` happens to equal the
plugin system's default for `handle_multiples`, so `extract_single` still resolves to
`handle_multiples = FALSE` and Migrate iterates it per delta as intended. The typo is harmless, not
a functional bug.
