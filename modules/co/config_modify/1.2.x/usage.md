Config Modify lets a module ship declarative modifications to *existing* configuration (that another module or core owns) in a `config/modify/` folder, applied automatically when Drupal would install optional config. It is a developer/deployment tool with no UI, permissions, or web-facing routes — modifications run at module-install time and via Drush.

---

The module swaps core's `config.installer` service for its own subclass (`ConfigModifyServiceProvider` → `src/ConfigInstaller.php`) and `update_helper`'s updater (`src/Updater.php`), so that after core installs `config/optional` it also processes `config/modify/*.yml` files from all enabled modules. Each file is named `<module>.<unique>.yml` and holds two top-level keys: `dependencies` (core config-dependency format — modules/config that must exist) and `items` (a map of config name → Config Update Definition in `update_helper`'s CUD `add`/`change`/`delete` format). A modification is applied only when its dependencies are met and it has not been applied before; applied files are recorded in the `config_modify.applied` config object so they never run twice. Modifications are skipped while config is *syncing* (the change was already made on the source environment) and when the `config_modify` module itself is first enabled (pre-existing files are marked applied to avoid update-hook race conditions). A Drush command scaffolds a `config/modify` file by diffing on-disk vs active config, and a `pre-update` command marks currently-applicable modifications as applied before running database updates. The whole mechanism is code/CLI driven; there is no admin form (`configure` is null), no permissions, and the only config schema is the `config_modify.applied` tracker.

---

- Ship a module that adds a field to a search index defined by another module, at install time.
- Add an item to a core/contrib config entity without owning or re-exporting it.
- Change a default value in another module's config during your module's installation.
- Delete a key from existing config as part of a feature module install.
- Gate a config modification on another module being enabled (via `dependencies.modules`).
- Gate a modification on another config object existing (via `dependencies.config`).
- Keep install-profile config tweaks in `config/modify` instead of post-install hooks.
- Make atomic, dependency-aware config edits that only apply once.
- Avoid config-sync conflicts by having modifications skip during a config import.
- Scaffold a `config/modify` file from current-vs-disk config diffs with Drush.
- Generate a modification in either direction (disk→database or database→disk).
- Record applied modifications in `config_modify.applied` to prevent re-running.
- Mark new modification files as applied before running `drush updb` (`config-modify:pre-update`).
- Distribute reusable feature modules that adjust shared config safely across sites.
- Add a datasource/field to a Search API index only when the source field exists.
- Bundle config alterations with a module rather than manual site-builder steps.
- Extend a View or form display owned by another module during install.
- Provide install profiles that layer modifications onto contrib default config.
- Ensure a modification runs only when its config dependency is present, else no-op.
