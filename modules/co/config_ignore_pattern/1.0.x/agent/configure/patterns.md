<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining ignore patterns

Patterns live in `settings.php` (trusted, code-level):

```php
$settings['config_ignore_patterns'] = [
  '/^system\.site$/',           // exact config name
  '/^webform\.webform\..*/',   // all webforms
  '/.*\.test_.*/',              // any test-prefixed key
];
// Optional: show which items were ignored and why.
$settings['config_ignore_pattern_debug'] = TRUE;
```

## How matching works
- Each **active** config name is tested; its declared `dependencies.config` are also tested, so ignoring a config also ignores dependents.
- Config that **already exists in file storage** (`config/sync`) is **not** ignored — tracked config keeps syncing.
- On **export**, matched items are deleted from the outgoing storage (never written to sync).
- On **import**, matched items are overwritten with the current active value, so `drush config:import` sees no change and will not delete them.
- Results are recorded in state: `config_ignored_export`, `config_ignored_import`.

## Caution
A too-broad regex silently removes config from exports. Prefer anchored, specific patterns and use the debug flag to verify.
