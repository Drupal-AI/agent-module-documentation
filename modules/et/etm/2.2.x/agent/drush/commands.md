<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`src/Drush/Commands/EtmCommands.php` (uses `AutowireTrait`; injects `entity_type.manager`). Built
for stress-testing the tree at scale.

## `etm:generate` (alias `etm-gen`)

Creates flat, root-level terms with zero-padded sequential names and sequential weights.

- Argument: `vocabulary` — target vocabulary machine name (must exist).
- Options: `--count` (default 100000), `--prefix` (default `Term`), `--batch-size` (default 500;
  `resetCache()` + `gc_collect_cycles()` every batch).
- Names are `"{prefix} {NNNNNN}"` (pad width = max(6, digits of count)); weights continue after the
  current max root weight.
- Examples: `drush etm:generate tags --count=100000`;
  `drush etm:generate categories --count=500 --prefix="Cat"`.

## `etm:purge` (alias `etm-purge`)

Deletes **all** terms in a vocabulary (interactive confirm, default No), in batches
(`--batch-size`, default 200), with `resetCache()` + `gc_collect_cycles()` between batches.

- Argument: `vocabulary` — machine name.
- Example: `drush etm:purge tags`.

Both commands use `accessCheck(FALSE)` — they are CLI maintenance tools, not request-time endpoints.
