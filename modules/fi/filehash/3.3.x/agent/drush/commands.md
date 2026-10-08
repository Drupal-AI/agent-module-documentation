<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Hash — Drush commands

From `src/Drush/Commands/FileHashCommands.php`.

| Command | Aliases | What it does |
|---|---|---|
| `filehash:generate` | `fgen`, `filehash-generate` | Runs the Generate batch: computes and stores hashes for **existing** files that don't have them yet (backfill after enabling an algorithm or installing the module on a site with files). |
| `filehash:clean` | `filehash-clean` | Runs the Clean batch: uninstalls field storage definitions for **disabled** algorithms, dropping their `file_managed` columns. Run this after unchecking an algorithm. |
| `filehash:report` | — | Prints a table of duplicate files (files sharing a hash with at least one other file). |

## `filehash:report` options

| Option | Default | Notes |
|---|---|---|
| `--limit` | `1000` | Max rows to return. |
| `--algorithm` | auto | Which enabled algorithm to compare on (e.g. `sha512_256`). Defaults to the last enabled algorithm. Errors if the named algorithm isn't enabled. |
| `--format` | `table` | Standard Drush output format (`table`, `json`, `csv`, …). |

```bash
drush filehash:generate                       # backfill missing hashes
drush filehash:clean                          # drop columns for disabled algorithms
drush filehash:report                         # up to 1000 duplicates
drush filehash:report --algorithm=sha256 --limit=50 --format=json
```

`filehash:report` throws if **no** algorithms are enabled ("No hash algorithms are enabled.")
and lists `fid`, `uri`, and the hash column for each duplicate.
