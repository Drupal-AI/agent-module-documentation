<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate process plugins

Namespace: `Drupal\migrate_process_array\Plugin\migrate\process`. Use each in a migration's `process:`
section. Shared behavior: empty `$value` returns NULL; a non-array `$value` is wrapped as `[$value]`;
an empty result array returns NULL (Migrate skips NULL). No config schema — configuration keys are read
directly from the process definition.

## array_intersect
Keeps only source values that appear in the `match` list (PHP `array_intersect` family).

Config keys:
- `match` (required): value or list of values to keep. A scalar is coerced to a one-item list.
- `method` (optional): comparison variant — `assoc` (`array_intersect_assoc`), `key`
  (`array_intersect_key`), `uassoc` (`array_intersect_uassoc`, needs `callable`),
  `ukey` (`array_intersect_ukey`, uses `callable`). Omitted/other → plain `array_intersect`.
- `callable` (optional): comparison callback used by `uassoc` / `ukey`.

```yaml
field_tags:
  plugin: array_intersect
  source: some_array_field
  match:
    - values
    - to
    - match
```

## array_diff
Drops source values that appear in the `exclude` list (PHP `array_diff` family).

Config keys:
- `exclude` (required): value or list of values to remove. Scalar coerced to a list.
- `method` (optional): `assoc` (`array_diff_assoc`), `key` (`array_diff_key`), `uassoc`
  (`array_diff_uassoc`, needs `callable`), `ukey` (`array_diff_ukey`, uses `callable`).
  Omitted/other → plain `array_diff`.
- `callable` (optional): comparison callback for `uassoc` / `ukey`.

```yaml
field_tags:
  plugin: array_diff
  source: some_array_field
  exclude:
    - values
    - to
    - match
```

## array_filter
Filters the source array (PHP `array_filter`).

Config keys:
- `callable` (optional): filter callback, same form as core's `callback` plugin — a function name or
  a `['\Drupal\my_module\MyClass', 'myMethod']` static-method pair. Omitted → default `array_filter`
  (removes falsy/empty values).

```yaml
field_of_array_values:
  plugin: array_filter
  source: some_array_field
  callable: 'my_function'
```

## deepen
Opposite of flatten: wraps each item of a flat array in its own sub-array. Useful after merging fields
so each value becomes a separate multi-value delta, ready for `sub_process`.

Config keys:
- `key` (optional): if set, each item becomes `[key => item]`; if omitted, each item becomes `[item]`.

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
Input `['123','456']` with `key: target_id` → `[['target_id'=>'123'], ['target_id'=>'456']]`.

## extract_single
Subclass of core's `extract` plugin with `handle_mulitples = FALSE`, so the `index` path is applied
within each field-delta value rather than only delta 0. No added config — takes the same `index` key
as core `extract`.

```yaml
my_field:
  source: some_field
  plugin: extract_single
  index:
    - my_key
```
For `[['my_key'=>'A'], ['my_key'=>'B']]` this yields the `my_key` value from every delta (core `extract`
would need `index: [0, my_key]` and return only the first).
