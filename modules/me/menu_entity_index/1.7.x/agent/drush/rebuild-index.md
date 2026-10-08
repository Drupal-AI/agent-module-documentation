<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: rebuild the index

One command, defined in `src/Drush/Commands/MenuEntityIndexCommands.php`.

```bash
# Rebuild the index for ALL tracked menus:
drush menu-entity-index:rebuild-index
drush mei-r                      # alias

# Rebuild the index for a single menu (must be a tracked menu):
drush menu-entity-index:rebuild-index main
drush mei-r main
```

Behavior:
- Reads the tracked menus from `Tracker::getTrackedMenus()`.
- Errors (exit non-zero) if you pass a menu that is **not** in the tracked list, or if no
  menus are configured for tracking at all.
- Deletes existing `menu_entity_index` rows for the target menu(s), then runs the
  `menu_entity_index_track_batch` operation (from `menu_entity_index.batch.inc`) via
  `drush_backend_batch_process()` to re-scan and re-insert them.

Use it after bulk-importing `menu_link_content` entities, changing which entity types are
tracked, or if you suspect the index has drifted. Normal editing keeps the index current
automatically, so routine use is unnecessary.
