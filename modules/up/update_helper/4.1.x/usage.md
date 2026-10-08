Update Helper makes shipping configuration changes in module and distribution update hooks easier: a Drush generator diffs your active config against a module's exported config and writes a Configuration Update Definition (CUD) plus a `hook_update_N()`, and a runtime service applies that CUD safely on `drush updatedb`.

---

The module has two cooperating halves. The **generator** (`drush generate update_helper:configuration-update`, aliases `config-update` / `configuration-update`) uses `config_update` and a reversible differ to compute the delta between the site's active configuration and a module's exported YAML, then writes a CUD file to `<module>/config/update/<name>.yml`, adds an update hook to `<module>.install`, and re-exports the changed config so code and database agree. The **runtime** side is the `update_helper.updater` service (`Drupal\update_helper\Updater`): a generated update hook calls `$updater->executeUpdate($module, $update_name)` and returns `$updater->logger()->output()`. `executeUpdate()` runs any `__global_actions` (install modules/themes, import configs) then applies each config's `update_actions` — but only when the live config still matches the CUD's `expected_config`, so hand-edited or already-updated config is skipped with a warning rather than clobbered; it returns TRUE only when no warnings were logged. Supporting services include `update_helper.config_handler` (builds/reads CUDs), `update_helper.config_differ` (`ReversibleConfigDiffer`), `update_helper.config_diff_transformer`, `update_helper.config_exporter`, and `update_helper.logger`. An event `UpdateHelperEvents::CONFIGURATION_UPDATE` fires after each update, which the optional `update_helper_checklist` submodule uses to track progress. The module has no admin UI, no permissions, and stores no configuration of its own; it depends on `config_update` and requires the project-local Drush ≥ 12.

---

- Ship a configuration change to an existing module via an update hook instead of asking site owners to reconfigure by hand.
- Generate a Configuration Update Definition (CUD) with `drush generate update_helper:configuration-update`.
- Automatically write the matching `hook_update_N()` into `<module>.install`.
- Diff active configuration against a module's exported config to capture exactly what changed.
- Apply a CUD at deploy time with `drush updatedb` (which runs the generated hook).
- Safely update config only when it still matches an expected baseline, avoiding clobbering local edits.
- Log per-config success/failure and surface it in the update output.
- Install modules or themes as part of a configuration update via `__global_actions: install_modules` / `install_themes`.
- Import whole config objects during an update via `__global_actions: import_configs`.
- Maintain configuration updates for a Drupal **distribution** across releases.
- Re-export changed configuration YAML automatically when generating an update.
- Provide a reversible config diff between two configuration states programmatically (`update_helper.config_differ`).
- Build or read CUD files in code via `update_helper.config_handler` (`generatePatchFile()`, `loadUpdate()`).
- Use the "reverse mode" workflow to generate an update from already-exported new config.
- Return human-readable update messages from a hook via `$updater->logger()->output()`.
- Detect that an update was skipped because the site's config had drifted from the expected baseline.
- React to applied configuration updates by subscribing to `update_helper.configuration.update`.
- Coordinate with `update_helper_checklist` to show site owners which updates remain.
- Keep module code and active configuration in sync after feature changes without manual `drush cim` gymnastics.
- Batch several config changes for one release into a single reviewable CUD file.
