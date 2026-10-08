# Extend — decorate the config installer & storages

## `FeaturesConfigInstaller` (service decorator)

`features.config.installer` **decorates** core's `config.installer` (`decoration_priority: 9`)
with `Drupal\features\FeaturesConfigInstaller`. This lets Features intercept module install so
config that is already present (or should be treated as pre-existing) is not re-created as new,
which is central to how importing a feature module reconciles with active config. To further
adjust install behavior, decorate `features.config.installer` in turn, or provide your own
higher-priority decorator of `config.installer`.

## Extension storages

`features.extension_storage` and `features.extension_optional_storage` are
`Drupal\features\FeaturesInstallStorage` instances reading each extension's `config/install`
and `config/optional` directories. Related classes you can build on:
`FeaturesExtensionStorages`, `FeaturesExtensionStoragesByDirectory`,
`FeaturesInstallStorage`. Use these to read config that ships in feature modules without
installing it.

## Plugins vs. decoration

For most customization prefer a **plugin** over decoration: add an assignment method to change
how config is grouped, or a generation method to change how packages are written — see
[../plugins/features.md](../plugins/features.md). Decorate services only when you must change
the install/reconcile machinery itself.

## Alter hooks

- `hook_features_assignment_info_alter(&$assignment_info)` — add/modify assignment methods.
- `hook_features_generation_info_alter(&$generation_info)` — add/modify generation methods.
