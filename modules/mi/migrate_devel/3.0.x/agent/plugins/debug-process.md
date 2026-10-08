<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `debug` migrate process plugin

Class `Drupal\migrate_devel\Plugin\migrate\process\Debug`
(`@MigrateProcessPlugin(id = "debug", handle_multiples = TRUE)`). Use it as a **breakpoint**
inside a migration `process:` pipeline: it `dump()`s data to the CLI and passes the incoming
value through **unchanged** to the next step.

## Configuration keys

| Key | Values | Effect |
|---|---|---|
| `dump` | `value` (default), `destination`, `source`, `source_ids`, `source_keys` | What to dump (see below). Note: with a non-`value` dump the plugin *returns that dumped data* as the value, replacing the incoming value. |
| `label` | any string | Printed (dumped) before the main output; include trailing space/punctuation yourself. |
| `multiple` | `true` / `false` | `multiple()` returns this; `true` tells the next step to process array values individually (like migrate_plus `multiple_values`). |

`dump` targets:
- `value` — the value passed into this step (default); returned unchanged.
- `destination` — `$row->getDestination()` (all destination values set so far).
- `source` — `$row->getSource()` (all source values).
- `source_ids` — `$row->getSourceIdValues()`.
- `source_keys` — `array_keys($row->getSource())`.

The dump uses the global `dump()` helper (Symfony VarDumper). Output appears when running the
migration from the **command line** (e.g. `drush migrate:import`).

## Examples

Inspect a value mid-pipeline (passes through unchanged):

```yaml
process:
  field_tricky:
    - plugin: debug
      source: whatever
    - plugin: some_next_plugin
```

Label the output and split arrays for the next step:

```yaml
process:
  field_tricky:
    - plugin: debug
      source: whatever
      label: 'Step 1: '
      multiple: true
    - plugin: some_next_plugin
```

Dump everything set on the destination so far:

```yaml
process:
  field_tricky:
    - plugin: debug
      dump: destination
```

## Notes for an agent

- It is safe to leave in during development and remove before production; there is nothing to
  configure or clean up beyond deleting the step.
- Because `handle_multiples = TRUE`, it can receive array values directly.
- With `dump: value` (default) the pipeline value is untouched; with any other `dump` value the
  *returned* value becomes the dumped structure — only use non-default `dump` on a step whose
  output you do not need to keep.
