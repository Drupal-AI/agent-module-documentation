<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Direct Queue (direct_queue) — agent index
**Drush command to process one specific queue item (by item_id + expire), meant to be driven by an external daemon.**

- **Version:** 8.x-2.x
- **Core:** ^8.8 || ^9 || ^10
- **Drush command:** `direct_queue:run($item_id, $expire)` (service `direct_queue.commands`, `src/Commands/RunCommand.php`).
- **Routes/permissions:** none — CLI only.

**Security:** No HTTP surface. `$item_id`/`$expire` are digit-filtered and bound as query params (no SQL injection). `unserialize()` on the queue payload has no `allowed_classes` restriction (`src/Commands/RunCommand.php`), but data is internal queue content and the command runs only from CLI — same trust model as core's database queue.

See [drush/run.md](drush/run.md)