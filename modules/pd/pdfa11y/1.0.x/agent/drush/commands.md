# Drush commands

Class `\Drupal\pdfa11y\Drush\Commands\Pdfa11yCheckCommand` (Drush 13+ attributes, autowired).

| Command | Alias | Purpose |
|---|---|---|
| `pdf-accessibility:check [media_id]` | `pa:check` | Run (or enqueue) accessibility checks on PDF media items. |

With a `media_id` argument it checks one item; without it, it bulk-selects media and processes in
chunks of 50 (resetting caches / `gc_collect_cycles()` between chunks). Results are written to the
`pdfa11y_results` table via the analyzer.

## Options

| Option | Default | Effect |
|---|---|---|
| `--bundle=NAME` | — | Restrict to a media bundle. Required for `--since-fid` / `--missing-only`. |
| `--limit=N` | `50` | Max items to select. |
| `--status=published\|unpublished\|any` | `any` | Publication-status filter. |
| `--since-fid=N` | `0` | Only items whose source fid > N (resume an interrupted run). Requires `--bundle`. |
| `--missing-only` | off | Only items with no stored result (rows whose `check_id` ≠ `_io_error`). Requires `--bundle`. |
| `--queue` | off | Enqueue selected ids into the `pdfa11y_check` queue and exit; drain with `drush queue:run pdfa11y_check`. |
| `--max-consecutive-failures=N` | `10` | Abort bulk run after N consecutive transient `_io_error` items (backend-health breaker). `0` disables. |
| `--skip-missing-files` | off | Skip orphaned media without recording `_missing_file`. |
| `--max-filesize=MB` | config `max_filesize` | Route files ≥ this size to `_too_large` without parsing. |
| `--max-image-bytes=MB` | config `max_image_bytes` | Route files whose estimated decompressed image payload ≥ this to `_image_payload_too_large` (xref preflight, no smalot). |
| `--no-subprocess` | off | Parse in-process instead of a forked child (debugging / no-pcntl platforms). |
| `--format=table\|summary\|csv\|json\|quiet` | `table` single, `summary` bulk | Output shape. `csv` → `php://output`; `json` emitted at quiet-verbosity so it survives `-q`. |

## Examples

```bash
drush pa:check 42                                   # one media item, table output
drush pa:check --bundle=document --limit=100        # up to 100 document media
drush pa:check --bundle=document --missing-only      # only never-checked items
drush pa:check --bundle=document --since-fid=12345   # resume after fid 12345
drush pa:check --bundle=document --queue             # enqueue, then queue:run
drush pa:check --format=json > report.json
```

The bulk summary reports counts per outcome: checked, with-issues, missing files, too large,
image-payload too large, subprocess failures, encrypted/permission-restricted, permanent parse
errors, transient I/O errors, skipped, and peak memory.
