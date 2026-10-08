Web Config is a meta-package that installs and turns on the most-needed Drupal configuration-management modules in one step via a bundled recipe.

---

Web Config (webconfig) is a thin config-management meta-package in the Webship / `web*` suite. It ships only `webconfig.info.yml`, `webconfig.install`, and `recipes/default/recipe.yml` — no PHP classes, routes, permissions, or config schema of its own. On install (when not applied as part of a config sync) its `hook_install()` applies the bundled `recipes/default` recipe, which enables core Configuration Manager (`config`) plus the contrib config toolkit — Configuration Update Manager (`config_update` + `config_update_ui`), Configuration Split (`config_split`), Config Ignore (`config_ignore`), Configuration Inspector (`config_inspector`), Configuration Rewrite (`config_rewrite`), and Config Import Single (`config_import_single`) — and imports each of those modules' default configuration. Config Filter (`config_filter`) comes along as a dependency of Config Split. The net result is a ready-to-use configuration workflow so a site builder can export/import, split per-environment, ignore selected config, inspect schema, rewrite config, and single-import/export without hand-picking modules. Supports Drupal `^11.4 || ^12`.

---

- Bootstrap a full config-management toolchain on a new site with one module enable.
- Standardize the config tooling across many sites in the Webship / `web*` suite.
- Enable core Configuration Manager and reach the config sync UI at `/admin/config/development/configuration`.
- Add Configuration Update Manager to compare active config against a module's shipped defaults.
- Use the Config Update report/UI (`config_update_ui`) to revert or import individual config items after a module update.
- Add Configuration Split to define per-environment config sets (e.g. dev vs. prod).
- Keep development-only modules' config out of production exports with Config Split.
- Add Config Ignore to protect selected active config from being overwritten on import.
- Preserve environment-specific settings (API keys, site mail, etc.) across `drush cim` with Config Ignore.
- Add Configuration Inspector to view the schema and validation state of any config object.
- Audit configuration for missing or mismatched schema with Configuration Inspector.
- Add Config Rewrite to programmatically alter another module's config on import.
- Layer site-specific overrides onto shipped config without patching modules, via Config Rewrite.
- Add Config Import Single to paste-import or export a single config item through the UI.
- Copy one config object between environments quickly with single import/export.
- Provide a consistent config workflow for a Composer-based deployment pipeline.
- Apply the recipe standalone (module enabled on its own) or let a parent recipe pull `webconfig` in.
- Serve as a documented dependency bundle so downstream recipes require config tooling transitively.
- Give devops teams a repeatable baseline for configuration management and drift control.
- Combine with Drush (`config:export` / `config:import`) for CI-driven config deployment.
