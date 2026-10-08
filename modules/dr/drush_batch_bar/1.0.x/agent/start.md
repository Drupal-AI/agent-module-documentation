<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Batch Bar (drush_batch_bar) — agent index

**Runs Batch API operations from Drush with a Symfony Console progress bar and concise summaries.**

- **Version:** 1.0.x · **Core:** ^10.4 || ^11.1 · **PHP:** >=8.4 · **Requires:** Drush 12+
- **API:** `new DrushBatchCommands(operations, title, finished)->execute()`; subclass `Drupal\drush_batch_bar\Batch\DrushBatchBar` for custom logic.
- **Helpers:** `ProcessCommands` (drush command, `@database`), `Log\Logger` (Drush-style output). Submodule `drush_batch_bar_example` → `drush drush-batch-bar` / `dbb`.
- **Security:** CLI-only developer tool; no web routes, permissions, or config. Batch-state `unserialize()` uses `['allowed_classes' => FALSE]` (`ProcessCommands.php:83`) — safe from object injection. No findings.

See [drush/usage.md](drush/usage.md)
