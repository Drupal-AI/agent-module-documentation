<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Read-only — agent index

Write-protects the **active config store**. Enabling the module does nothing on its own —
the switch is `$settings['config_readonly'] = TRUE;` in `settings.php`. There is **no admin
UI, no configure route, no permissions, no Drush commands, no plugins, no config schema**.

- **Turn the lock on/off, whitelist config, check whether it is active** →
  [configure/lock.md](configure/lock.md)
- **What actually blocks writes (storage decorator, form subscriber, bypasses, exception)** →
  [api/mechanism.md](api/mechanism.md)
- **`hook_config_readonly_whitelist_patterns()` and the `ReadOnlyFormEvent`** →
  [hooks/extension-points.md](hooks/extension-points.md)

Key facts:
- Settings keys: `config_readonly` (bool), `config_readonly_whitelist_patterns` (array of
  patterns, `*` is the only wildcard, anchored to the whole config name).
- `config.storage` is replaced with `Drupal\config_readonly\Config\ConfigReadonlyStorage`
  by `ConfigReadonlyServiceProvider::alter()` — **always**, even when the lock is off.
- Blocked writes throw `Drupal\config_readonly\Exception\ConfigReadonlyStorageException`.
- Bypasses: an in-progress `ConfigImporter` run (`drush config:import`) and the
  `system.db_update` route (`update.php`).
