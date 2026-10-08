# API — applying configuration updates (update_helper.updater)

## The runtime pattern

A generated update hook looks exactly like this (from
`templates/configuration_update_hook.php.twig`):

```php
/**
 * My update description.
 */
function mymodule_update_9001(): string {
  /** @var \Drupal\update_helper\Updater $updater */
  $updater = \Drupal::service('update_helper.updater');
  // Apply the CUD stored at mymodule/config/update/mymodule_update_9001.yml.
  $updater->executeUpdate('mymodule', 'mymodule_update_9001');
  // Return logged messages to the update channel.
  return $updater->logger()->output();
}
```

`Drupal\update_helper\UpdaterInterface`:

- `executeUpdate(string $module, string $update_definition_name): bool` — loads the CUD
  `<module>/config/update/<update_definition_name>.yml`, runs its **global actions** then its
  **per-config actions**, dispatches `UpdateHelperEvents::CONFIGURATION_UPDATE`, and returns
  **TRUE when zero warnings** were logged (a warning marks the update as failed but does not
  throw). The `$update_definition_name` is conventionally the same string as the update hook
  function name.
- `logger(): \Drupal\update_helper\UpdateLogger` — the update logger; call `->output()` to get
  the accumulated messages to return from the hook (they show up in `drush updatedb` / update.php).

## CUD (Configuration Update Definition) file format

Stored as YAML at `<module>/config/update/<name>.yml`. Two top-level sections:

- **`__global_actions`** (`UpdateDefinitionInterface::GLOBAL_ACTIONS`) — optional, with any of:
  - `install_modules`: list of modules to install
  - `install_themes`: list of themes to install
  - `import_configs`: list of config names to import from the module's config folders
- **One key per config name** being changed, each with:
  - `expected_config`: the config as it must currently be for the patch to apply
  - `update_actions`: `add` / `change` / `delete` deltas to merge in

`Updater::updateConfig()` only applies the change when the live config still matches
`expected_config` (so an already-updated or hand-edited config is skipped, and a warning is
logged rather than clobbering it).

## Services (update_helper.services.yml)

| Service id | Class | Role |
|---|---|---|
| `update_helper.updater` | `Updater` | applies CUDs from update hooks (`executeUpdate`) |
| `update_helper.config_handler` | `ConfigHandler` | `generatePatchFile()`, `loadUpdate()`, `getPatchFile()` — builds/reads CUDs |
| `update_helper.config_differ` | `ReversibleConfigDiffer` | reversible diff between two config arrays |
| `update_helper.config_diff_transformer` | `ConfigDiffTransformer` | flatten/expand config for diffing |
| `update_helper.config_exporter` | `ConfigExporter` | writes changed config to the module's YAML files |
| `update_helper.logger` | `UpdateLogger` | buffers info/warning messages for the hook to return |

## Events

`Drupal\update_helper\Events\UpdateHelperEvents`:

- `COMMAND_GCU_INTERACT` = `update_helper.command.gcu.interact`
- `COMMAND_GCU_EXECUTE` = `update_helper.command.gcu.execute`
- `CONFIGURATION_UPDATE` = `update_helper.configuration.update` (dispatched after each
  `executeUpdate()`, carries `ConfigurationUpdateEvent` with module, update name, warning count)

Subscribe to `CONFIGURATION_UPDATE` to react to applied updates (this is how
`update_helper_checklist` marks checklist items complete).
