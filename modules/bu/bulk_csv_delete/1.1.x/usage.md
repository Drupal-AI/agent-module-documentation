A Drush command that bulk-deletes Drupal nodes by matching a chosen field against a column of a CSV file, with dry-run, batching, and detailed log files.

---

Bulk CSV Delete adds one Drush command, `bulk-csv-delete:run` (alias `bcd`), for deleting large sets of nodes from the command line. You point it at a CSV file, a content type, and a `field_name:column` match spec; it extracts the unique, non-empty values from that CSV column, resolves the field's storage table/column via Drupal field metadata, and runs a direct `SELECT ... WHERE value IN (...)` to find matching node IDs — no entity loading, so matching stays fast even at 100,000+ values. It previews the CSV and the match counts, warns if the field column is not indexed, then (unless `--dry-run`) asks for confirmation and deletes the matched nodes through the entity API in batches, resetting the entity static cache between batches so memory stays flat. Every run writes a timestamped log file (default `private://bulk_csv_delete_logs`) recording parameters, CSV stats, matches, per-node deletions, not-found values, multi-match details, errors, and a summary. It is a maintenance/admin CLI tool: there is no web UI, form, route, or permission, and it operates on nodes only.

- Bulk-delete legacy or migrated `article` nodes by matching `field_external_id` against column 1 of an export CSV.
- Preview a deletion with `--dry-run` to see match counts and the CSV column mapping before deleting anything.
- Clean up 100,000+ nodes efficiently, relying on the fast SQL matching phase and batched entity deletion.
- Delete nodes whose `field_legacy_id` appears in a CSV exported from an old system after a content migration.
- Match on a base node property such as `nid`, `title`, or `uuid` (e.g. `--match=nid:1`) to delete by ID list.
- Match on an entity-reference field using target IDs in the CSV (e.g. `--match=field_category:1` with term IDs).
- Match on an email, link, integer, decimal, or list field — the correct storage column is resolved automatically.
- Delete only a subset of matched nodes by adding `--filter=field_category:"Some Term"` to keep those referencing one taxonomy term.
- Skip a header row in the CSV with `--has-header`.
- Parse semicolon- or tab-delimited exports by passing `--delimiter=";"`.
- Match a value that sits in a later CSV column (e.g. `--match=field_sku:4` for column 4).
- Tune throughput and memory with `--batch-size` (1–500, default 50) — smaller batches for complex content types, larger for simple ones.
- Throttle CPU/database load on shared or replicated environments with `--delay=<milliseconds>` between batches.
- Write logs to a custom directory with `--log-dir=/tmp/delete_logs` for a one-off run.
- Get a warning (and a ready-to-paste `ALTER TABLE ... ADD INDEX` statement) when the match field has no database index.
- Review a timestamped per-run log listing every deleted node ID and the CSV value that matched it, for auditing.
- Identify CSV values that matched no node (reported and logged as "not found") to reconcile an export against live content.
- Spot CSV values that matched multiple nodes (multi-match note + log detail) before committing to a deletion.
- Remove all translations of a matched node at once — deleting a node removes every language variant.
- Run repeated cleanups after each import by scripting the command in a deployment or maintenance job.
- Delete nodes across an entire content type from a spreadsheet of identifiers maintained by an editorial team.
