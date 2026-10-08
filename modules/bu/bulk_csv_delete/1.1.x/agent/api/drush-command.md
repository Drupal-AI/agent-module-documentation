<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command: `bulk-csv-delete:run` (alias `bcd`)

Source: `src/Drush/Commands/BulkCsvDeleteCommands.php`, class `BulkCsvDeleteCommands extends
DrushCommands`. Auto-discovered from `src/Drush/Commands/` (there is **no `drush.services.yml`**),
so the command gets no constructor injection; each service is lazily fetched via
`\Drupal::service()` in helper accessors (`csvParser()`, `nodeMatcher()`, `batchDeleter()`,
`deleteLogger()`).

## Install / enable

```bash
composer require drupal/bulk_csv_delete
drush en bulk_csv_delete
```

Requires Drupal `^10 || ^11`, PHP `^8`, Drush 12+. A working **private file system** is needed for
the default log directory (`private://bulk_csv_delete_logs`); otherwise pass `--log-dir` pointing at
a writable path.

## Signature

```
drush bcd <csv_file> [--content-type=…] [--match=field:column] [options]
```

`run(string $csv_file, array $options)` — the one command method (`@command bulk-csv-delete:run`,
`@aliases bcd`). `$csv_file` is a filesystem path or stream URI (resolved with
`file_system->realpath($csv_file) ?: $csv_file`).

### Options (defaults from the method signature)

| Option | Default | Meaning |
|---|---|---|
| `--content-type` | *(required)* | Node bundle machine name. |
| `--match` | *(required)* | `field_name:column`, column **1-based**. Field must exist on the bundle. |
| `--has-header` | `false` | Skip the first CSV row. |
| `--batch-size` | `50` | Nodes per delete batch; validated to **1–500**. |
| `--delimiter` | `,` | CSV delimiter passed to `fgetcsv`. |
| `--dry-run` | `false` | Match + preview only, no deletion. |
| `--log-dir` | `private://bulk_csv_delete_logs` | Log directory (URI or path). |
| `--delay` | `0` | Milliseconds slept between batches (`usleep($delay*1000)`), to cap CPU/DB load. |
| `--filter` | `null` | `field_name:term_name` — keep only nids whose taxonomy-reference field points at that term. |

## Validation (`buildConfig()`)

Returns FALSE (aborting) on any of: empty `--content-type`; empty `--match`; `--match` not exactly
`something:numeric`; column < 1; CSV path missing/unreadable; content type not a known node bundle
(`entity_type.bundle.info`); match field not in `entity_field.manager->getFieldDefinitions('node',
$bundle)`; batch size outside 1–500. For `--filter`: format must be `field:term` (both non-empty),
the filter field must exist and be an `entity_reference` to `taxonomy_term`, and the term name must
resolve (via an entity query with `accessCheck(FALSE)`, scoped to the field's `target_bundles` if
set) to **exactly one** tid — zero or multiple terms is an error. Valid config is stored in
`$this->runConfig` (includes `column_index = column_number - 1`).

## Run flow (`run()`)

1. `buildConfig()` — validate and store config.
2. `showNotices()` — prints large-dataset and multilingual warnings.
3. `checkFieldIndex()` — for custom fields, `NodeMatcherService::isFieldIndexed()`; if unindexed,
   warns and prints a ready `ALTER TABLE {table} ADD INDEX idx_{col} ({col}(191))`.
4. `deleteLogger()->open()` — create/verify log dir, open `Y-m-d_His.log` (`dry_run_` prefixed for
   dry runs); a `\RuntimeException` (e.g. private FS unavailable) aborts with an error.
5. `parseCsv()` → `CsvParserService::parse()`; logs row/value/skip/dup stats; aborts if no values.
6. `showPreFlight()` — title, config table, first-3-rows CSV preview with the `[MATCH]` column marked.
7. `NodeMatcherService::findMatchingNodes()` → nids + not-found + multi-match; results shown & logged.
8. If `--filter`, `NodeMatcherService::filterNidsByField()` narrows the nids; the pass/filter counts
   are shown and logged.
9. If zero matches → warn and stop. If `--dry-run` → report "would delete N", close log, stop.
10. Build a `nid → matched CSV value` map, print an irreversible-action warning, and
    `$io->confirm('Proceed?', FALSE)` (**defaults to No**). Abort logs "User aborted."
11. `deleteAndSummarize()` → `BatchDeleterService::deleteBatches()` with a progress closure that
    prints a per-batch line (percent, speed, elapsed, ETA) and logs one `[DELETED] nid … | field =
    "value"` line per node plus a per-batch summary.
12. `printSummary()` — a metrics table (Deleted / Not found in CSV / Errors / Duration / Avg speed),
    logs the summary and any per-nid errors, closes the log, prints the log path.

## Log files

`DeleteLoggerService` writes `private://bulk_csv_delete_logs/<Y-m-d_His>.log` (or `dry_run_…`),
each line timestamped. Content: run header (all parameters), CSV stats, match counts, a
`--- NOT FOUND VALUES ---` list, a `--- MULTI-MATCH VALUES ---` list, per-node `[DELETED]` lines,
per-batch summaries, an error section, and a final `=== SUMMARY ===`.

## Scope & behavior notes

- **Nodes only** — bundle, field, and deletion all target the `node` entity type. The info.yml says
  "entities" but there is no code path for other entity types.
- Matching is done in SQL against field storage; **entities are loaded only in the deletion phase**
  (`BatchDeleterService`), so hooks (`hook_entity_predelete` / `hook_entity_delete`) DO fire on
  delete, and related data (revisions, aliases, search index) is cleaned up by core.
- A CSV value may match several nodes and a node may match several values; the nid list is
  de-duplicated before deletion.
- Deleting a node deletes **all translations**.
- Performance guidance (from the module): matching is seconds even at 100K values; deletion is the
  cost (~50–200 nodes/sec). For 10,000+ nodes, temporarily disable Search API indexing, Pathauto,
  and custom `hook_entity_delete` implementations, then re-index/re-enable. Use `--delay` to throttle.
