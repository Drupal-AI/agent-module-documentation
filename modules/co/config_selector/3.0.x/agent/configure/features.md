# Configuration Selector — features & selection

Configuration Selector is configured entirely through **config entity YAML**, not an admin form.
You mark competing config entities with a shared *feature* name and a *priority*; the module keeps
the highest-priority enabled variant and disables the others whenever modules are installed or
uninstalled.

## Opt a config entity into a feature

Add third-party settings and a module dependency to the config entity's YAML (in `config/optional/`
or `config/install/`):

```yaml
# e.g. views.view.my_listing.yml
langcode: en
status: true
dependencies:
  module:
    - config_selector      # REQUIRED so the settings are not stripped
third_party_settings:
  config_selector:
    feature: my_listing_feature   # shared name across all competing variants
    priority: 10                  # integer; higher wins
    description: 'Basic listing'  # optional fallback label
# ... rest of the view/block config ...
```

Ship several YAML files that share the same `feature` but differ in `priority` (and typically in
their own `dependencies.module`, e.g. one variant depends on `search_api`). Put them in
`config/optional/` so core only installs the ones whose dependencies are met.

## How selection works

- On **install** (`hook_module_preinstall` snapshots the config list, `hook_modules_installed`
  processes it): among the newly-active variants sharing a feature, the one with the highest
  `priority` stays enabled and every other enabled variant of that feature is set to `status: false`.
- On **uninstall** (`hook_module_preuninstall` / `hook_modules_uninstalled`): if uninstalling a
  module disabled/removed the active variant and *no* variant of that feature is left enabled, the
  highest-priority remaining variant is re-enabled.
- Selection is **non-destructive** — losing variants are only disabled, never deleted, so any user
  customizations survive and re-enabling a dependency can restore a tuned variant.
- Status messages/log entries are emitted naming which config was enabled/disabled.

The logic lives in the `config_selector` service (`\Drupal\config_selector\ConfigSelector`), invoked
automatically by the module's install hooks. `hook_module_implements_alter` reorders the module's
pre-hooks to run first and post-hooks to run last, so its snapshot/selection brackets other modules'
config work. You normally never call the service directly.

## Requirements & limitations

- A participating config entity **must be disable-able** (support `status`). Many config entity types
  (e.g. fields, node types) cannot be disabled and are unsupported.
- **Config schema** for the third-party settings ships only for Views (`views.view.*.third_party.config_selector`)
  and Blocks (`block.block.*.third_party.config_selector`), both mapped to type
  `config_selector_third_party` (keys: `feature` string, `priority` integer, `description` label).
  To use another config entity type, add a matching schema mapping in your module, e.g.:

```yaml
# my_module.schema.yml
my_entity_type.*.third_party.config_selector:
  type: config_selector_third_party
```

## Feature entity & UI

- A `config_selector_feature` config entity type exists (config prefix `config_selector.feature.`,
  exported keys `id`, `label`, `description`). Schema: `config_selector.feature.*`.
- Admin list: `/admin/structure/config_selector` (route
  `entity.config_selector_feature.collection`, permission **`administer site configuration`**). The
  menu link only appears when features exist (a deriver hides it otherwise).
- A manage form (`entity.config_selector_feature.manage`) and a CSRF-protected switch route
  (`config_selector.select`, also `administer site configuration`) exist, but the add/edit/delete
  form classes referenced by the entity are stubs/`@todo`. Treat the module as developer-driven
  (edit YAML); do not rely on the UI to create features.

## No permissions / no Drush

The module defines **no** permissions of its own (routes reuse core `administer site configuration`)
and ships **no** Drush commands.
