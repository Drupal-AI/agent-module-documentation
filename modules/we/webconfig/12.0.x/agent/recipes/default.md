<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Config default recipe & config workflow

Source: `recipes/default/recipe.yml` and `webconfig.install`. Web Config carries no code of its
own — everything below is delivered by the bundled recipe and by the modules it enables.

## How the recipe runs
`webconfig.install` implements `hook_install($is_syncing)`:

```php
function webconfig_install($is_syncing) {
  if (\Drupal::isConfigSyncing()) {
    return;                       // config import brings its own config
  }
  if (!$is_syncing) {
    RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'));
  }
}
```

So enabling `webconfig` on its own applies `recipes/default`; when a parent recipe installs
`webconfig`, the recipe was already applied and the hook does nothing.

## recipe.yml
- `type: install`
- `install:` (modules enabled, in order) — `config` (core Configuration Manager),
  `config_update`, `config_update_ui`, `config_split`, `config_ignore`, `config_inspector`,
  `config_rewrite`, `config_import_single`, and finally `webconfig`.
- `config:` — `strict: false`, and `import:` of `'*'` (all shipped default config) for
  `config_update`, `config_split`, `config_ignore`, `config_inspector`, `config_rewrite`,
  and `config_import_single`.

`config_filter` is not listed explicitly; it is enabled transitively as a Config Split dependency
(declared in composer.json `require`).

## What each enabled module gives the site builder
- **config** (core) — the Configuration synchronization UI at
  `/admin/config/development/configuration`; full-site export/import (or `drush config:export` /
  `drush config:import`).
- **config_update / config_update_ui** — report and revert individual config items against a
  module's shipped defaults; UI under `/admin/config/development/configuration/report`.
- **config_split** — per-environment config sets (e.g. enable dev tools only in dev); admin at
  `/admin/config/development/configuration/config-split`.
- **config_ignore** — protect selected active config from being overwritten on import; admin at
  `/admin/config/development/configuration/ignore`.
- **config_inspector** — inspect schema/validation of any config object; UI at
  `/admin/config/development/configuration/inspect`.
- **config_rewrite** — let modules rewrite/override other modules' config on import.
- **config_import_single** — paste-import or export a single config item through the UI at
  `/admin/config/development/configuration/single/import` (and `/export`).
- **config_filter** — plumbing that Config Split/Ignore build on (config transformation pipeline).

## Typical workflow after install
1. Confirm the toolkit is enabled: `drush pml | grep config`.
2. Review/export active config at `/admin/config/development/configuration` or `drush cex`.
3. Define per-environment splits (Config Split) and ignore rules (Config Ignore).
4. Commit exported config; deploy with `drush cim` in CI.
5. After a contrib update, use the Config Update report to import/revert changed items.

## Config Split admin page
Delivered by the bundled `config_split` module at
`/admin/config/development/configuration/config-split` (part of what this recipe enables):

![Config Split settings page provided by the bundled config_split module](../../../../../../../screenshots/webconfig/12.0.x/config-split.png)
