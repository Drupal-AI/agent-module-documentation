<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crisis Mode — enable/disable API & Drush

Crisis mode is a single boolean state kept in sync between `crisis_mode.settings:crisis_mode_active` and the enabled/disabled status of the block config entity `crisismodeblock`. Two entry points flip it.

## 1. Settings form
`\Drupal\crisis_mode\Form\CrisisModeSettingsForm::submitForm()` — POST to `/admin/config/system/crisis_mode` (permission `administer crisis mode`, Drupal form/CSRF token applies). Ticking "Crisis Situation" sets `crisis_mode_active` and calls `Block::load('crisismodeblock')->enable()->save()`; unticking disables it. Every submit ends with `drupal_flush_all_caches()`. See config/settings.md for the full save flow.

## 2. Drush command
`\Drupal\crisis_mode\Commands\CrisisModeCommands` (service `crisis_mode.commands`, tagged `drush.command`; constructor args `@config.factory`, `@plugin.manager.block`).

- Command: `crisis-mode` (alias `crisis`), one optional argument `$flag` defaulting to `on`.
- `crisisModeCommand($flag)` accepts only `on` or `off` (anything else → error), then calls `crisisModeSwitch($flag)`.
- `crisisModeSwitch()` uses the **editable** `crisis_mode.settings`: `on` sets `crisis_mode_active = 1`, saves, and `$block->enable()`; `off` sets `0`, saves, and `$block->disable()`; then `$block->save()`.

Usage:
```
drush crisis-mode on     # or: drush crisis on
drush crisis-mode off
```
(The documented `crisis-mode:on` / `crisis-mode:off` forms from the project page map to passing the `on`/`off` argument.) The Drush path updates config + block state but does not itself flush caches the way the form does.

## State summary
| Trigger | `crisis_mode_active` | Block `crisismodeblock` |
|--------|----------------------|--------------------------|
| Form save, checkbox on | 1 | enabled |
| Form save, checkbox off | 0 | disabled |
| `drush crisis-mode on` | 1 | enabled |
| `drush crisis-mode off` | 0 | disabled |
| Fresh install | 0 | disabled (created) |
| Uninstall | — | deleted |
