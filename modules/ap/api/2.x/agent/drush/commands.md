<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API module — Drush

Commands are defined in `src/Commands/ApiCommands.php` (registered via `drush.services.yml`). They drive parsing/reparsing and maintenance of the documentation entities — use them to (re)generate docs from CI or cron instead of the admin branch-parse route.

Typical workflow:
- Reparse a branch after code changes rather than clicking the parse route.
- Run after `drush cr` so new source files are picked up.
- Combine with cron/queue runners since parsing is queued (`ParseQueueWorker`).

Run `drush list | grep api` on the site to see the exact command names/signatures for the installed version, then `drush <command> --help`. All parsing operates on admin-configured branch sources, not request input.
