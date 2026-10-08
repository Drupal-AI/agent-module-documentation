<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DrushDialogLogRepository & drush_dialog_log table

`src/DrushDialogLogRepository.php`, registered as service `drush_dialog.repository`
(`drush_dialog.services.yml`, args `@database`, `@logger.channel.default`). It is the only
persistence layer; the controller writes every run to it and reads history from it.

## Table (`drush_dialog_schema()` in `drush_dialog.install`)

`drush_dialog_log`, "Stores drush commands and output runned with Drush dialog module.":

| Field | Type | Notes |
|---|---|---|
| `id` | serial | primary key |
| `uid` | int, not null, default 0 | creator's `{users}.uid` |
| `created` | int unsigned big, not null | Unix timestamp |
| `command` | varchar(255), not null, default '' | the Drush command + params |
| `output` | text (big), nullable | command output |

Index `name` on `uid`. Created on install, dropped on uninstall by core (schema-based).

## Methods

- `insert(array $entry): int|null` — `connection->insert('drush_dialog_log')->fields($entry)
  ->execute();` wrapped in try/catch; on failure logs via `Error::logException($this->logger,$e)`
  and returns `NULL`. Called by the controller with keys `uid`, `created`, `command`, `output`.
- `load(int $uid): array` — `connection->select('drush_dialog_log')->condition('uid', $uid)
  ->orderBy('created','DESC')->range(0,100)->fields('drush_dialog_log', ['command'])->execute()
  ->fetchCol();` — returns up to 100 `command` strings for that user, newest first. Output is
  **not** returned to the history endpoint (only `command`).

Both use the Drupal DB abstraction with parameterized conditions/fields (no string-built SQL).
Reads are scoped to the passed `$uid`; the controller always passes `currentUser()->id()`, so a
user sees only their own history.
