<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_enforce — Drush

Registered via `drush.services.yml` → `\Drupal\config_enforce\Commands\ConfigEnforceCommands`
(requires the optional `drush/drush` suggest; boots at `DrupalBootLevels::MAX`).

## `config-enforce:enforce` (alias `cee`)

Re-imports any enforced (level-20) configuration whose active value has drifted from the YAML on disk —
the same `ConfigEnforcer::enforceConfigs()` the cache-rebuild trigger runs.

```bash
drush config-enforce:enforce            # enforce all read-only configs
drush cee                               # alias
drush config-enforce:enforce --only-optional   # limit to configs in config/optional
```

- `--only-optional` — skip enforced configs stored in `config/install`, re-importing only those in
  `config/optional`.
- Progress and results are logged (config_enforce logger channels) and a success line is printed. Files
  that are missing/unreadable produce a warning and are skipped.

Use it after deploying changed config YAML, or to force a site back to its enforced values without a
full cache rebuild.
