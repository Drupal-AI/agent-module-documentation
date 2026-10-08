# features — agent start

Packages site configuration into installable "feature" modules. Config is grouped into
**packages** by **assignment method** plugins, then written out by **generation method**
plugins; the pipeline is configured by a `features_bundle` config entity. Depends on core
`config` and the `config_update` contrib module. Main module has **no UI** of its own — the
`features_ui` submodule provides `/admin/config/development/features`.

Note: on modern Drupal, core config sync (CMI) + `config_split` is usually preferred for
syncing a whole site between environments; Features shines for bundling reusable,
distributable config (distributions/profiles).

- Drush cycle: export / import / diff / status / list / components → [drush/features.md](drush/features.md)
- Bundles + assignment/generation settings (`features_bundle`) → [configure/features.md](configure/features.md)
- Assignment & generation method plugin types (implement your own) → [plugins/features.md](plugins/features.md)
- Call `features.manager` / assigner / generator services in code → [api/features.md](api/features.md)
- Decorate/override the config installer & storages → [extend/features.md](extend/features.md)
