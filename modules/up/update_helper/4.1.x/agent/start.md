# Update Helper (update_helper) — agent index

Makes shipping **configuration updates** in module/distribution update hooks easier. Two
halves: (1) a **Drush generator** that diffs your active config against a module's exported
config and writes a *Configuration Update Definition* (CUD) YAML file plus a `hook_update_N()`
into the module; (2) a runtime **`update_helper.updater`** service that applies a CUD from an
update hook and logs the result. **No admin UI** (`configure` = null), no permissions, no
config entities of its own. Depends on `config_update`.

- **Applying a CUD from an update hook — the `update_helper.updater` service, `executeUpdate()`,
  the CUD file format, global actions, and the other services** → [api/updater.md](api/updater.md)
- **Generating a CUD + update hook with Drush (`drush generate`), from-active vs reverse mode,
  where files land** → [drush/generate.md](drush/generate.md)

Key facts:
- Runtime API: `\Drupal::service('update_helper.updater')->executeUpdate($module, $update_name)`
  returns TRUE when no warnings were logged; `->logger()->output()` returns the messages to
  return from the update hook.
- The generator command is `drush generate update_helper:configuration-update`
  (alias `config-update`; historically `drush generate configuration-update`). It writes the CUD
  to `<module>/config/update/<update_name>.yml` and the hook to `<module>.install`, and exports
  changed config YAML.
- Services (in `update_helper.services.yml`): `update_helper.updater`, `update_helper.config_handler`,
  `update_helper.config_differ` (`ReversibleConfigDiffer`), `update_helper.config_diff_transformer`,
  `update_helper.config_exporter`, `update_helper.logger` (`UpdateLogger`).
- Event `UpdateHelperEvents::CONFIGURATION_UPDATE` (`update_helper.configuration.update`) fires
  after each `executeUpdate()`; the checklist submodule subscribes to it.
- Submodule **update_helper_checklist** adds a checklistapi checklist of executed updates —
  see modules/update_helper_checklist/4.1.x/.
