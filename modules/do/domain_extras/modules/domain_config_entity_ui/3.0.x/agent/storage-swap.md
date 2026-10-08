# Storage-swap mechanism

The problem: config *entities* are read **override-free** on admin paths (core's `AdminPathConfigEntityConverter`, `ConfigEntityListBuilder::load()`, `BlockListBuilder::submitForm()`, …), so a list builder or edit form shows base values even when the active domain has a per-domain override. domain_config_ui only handles `ConfigFormBase`. This submodule folds the active domain's override back onto those override-free reads for selected config entity types.

## Pieces and how they connect

1. **`DomainAwareSwapRegistry`** (`src/DomainAwareSwapRegistry.php`)
   - `getSwaps()` (post-discovery callers, e.g. the form) and `computeSwaps(array $entity_types)` (safe inside `hook_entity_type_alter`, avoids re-triggering the alter).
   - Returns a map `entity_type_id => [DomainAwareConfigEntityStorage::class, ConfigEntityStorage::class]` for every `ConfigEntityTypeInterface` whose current storage class is `ConfigEntityStorage` **or** already a `DomainAwareConfigEntityStorageInterface` (so an enabled type stays listed).
   - Fires `hook_domain_config_entity_ui_swaps_alter($swaps)` so contrib can add or remove entries.

2. **`DomainConfigEntityUiEntityTypeHooks::entityTypeAlter()`** (`src/Hook/…EntityTypeHooks.php`, `#[Hook('entity_type_alter')]`)
   - Reads `domain_config_entity_ui.settings:covered_entity_types`; returns early if empty.
   - For each swap whose id is in `covered`, sets the domain-aware `storage_class` **only if** the type's current class strictly equals the expected class (`getStorageClass() !== $expected_current_class` → skip). This strict-equality guard preserves any contrib custom storage handler.

3. **`DomainAwareConfigEntityStorage`** + **`DomainAwareConfigEntityStorageTrait`** (`src/Entity/…`)
   - The class is a thin `ConfigEntityStorage` subclass that mixes in the trait and implements the marker `DomainAwareConfigEntityStorageInterface`.
   - `DomainAwareConfigEntityStorageTrait::doLoadMultiple()` only acts when `$this->overrideFree` is TRUE, there are entities, and there is an active domain (`DomainConfigUIManagerInterface::getActiveDomainId()`). For each entity whose config name is both `isAllowedConfiguration()` and `isConfigurationRegisteredForDomain($domain_id, …)`, it reads that domain's row from `domain.config_factory_override` `getStorage($domain_id)` and `$entity->set()`s each key, then adds the override's cacheable metadata. Regular (non-override-free) loads, saves, and CLI short-circuit to the parent — the normal `ConfigFactory` override stack handles those.

4. **`DomainOverrideConfigEntityConverter`** (`src/ParamConverter/…`, service `domain_config_entity_ui.paramconverter.configentity_admin`, priority 10)
   - Extends core `AdminPathConfigEntityConverter`. `applies()` first defers to `parent::applies()`, then claims the route **only** when the entity type is hardcoded in the slug (`entity:foo`, not `entity:{entity_type}`), is a config entity type, and its storage is a `DomainAwareConfigEntityStorageInterface` — this avoids tying on priority with `ViewUIConverter` and displacing it.
   - `convert()` defers to the parent for non-config or non-domain-aware types; otherwise, when there is an active domain and the config name is both `isAllowedConfiguration()` and `isRegisteredConfiguration()`, it loads via the domain-aware `$storage->load($value)` (override-merged) so the edit form reflects per-domain values. Everything else falls back to override-free `parent::convert()`.

5. **`DomainConfigEntityUiFormHooks::formAlter()`** (`#[Hook('form_alter')]`)
   - When there is an active domain and `isAllowedRoute()`, and the form object is an `EntityForm` editing an existing `ConfigEntityInterface` whose storage is domain-aware, calls the parent module's `DomainConfigUiFormHooks::enableDomainConfigForm($form, [configDependencyName])` to add the "Enable domain configuration" toggle. Also `disallowedConfigurationsAlter()` marks `domain_config_entity_ui.settings` itself as never overridable.

6. **`SettingsForm`** (`src/Form/SettingsForm.php`, `ConfigFormBase`)
   - Builds a `checkboxes` element from `DomainAwareSwapRegistry::getSwaps()`, skipping types whose provider module is disabled. `#config_target` maps between the stored list and the checkbox map. Ships a prominent warning that only `block` is validated. Stores into `covered_entity_types`.

7. **`DomainConfigEntityUiSettingsSubscriber`** (`ConfigEvents::SAVE`)
   - On save of `domain_config_entity_ui.settings` when `covered_entity_types` changed, calls `entityTypeManager->clearCachedDefinitions()` so the new coverage applies next request without `drush cr`.

## Two opt-in layers

- **Coarse:** the module must be installed for any swap.
- **Fine:** per-entity-type checkboxes in `covered_entity_types` choose which discovered types actually get swapped.

## Contrib extension: `hook_domain_config_entity_ui_swaps_alter()`

Auto-discovery only covers types whose default handler is vanilla `ConfigEntityStorage`. Types with a custom handler (`image_style` → `ImageStyleStorage`, `user_role` → `RoleStorage`, `menu` → `MenuStorage`) need a sibling `DomainAware*Storage` that **extends that custom handler**, uses `DomainAwareConfigEntityStorageTrait`, and implements `DomainAwareConfigEntityStorageInterface`. Register it:

```php
function my_module_domain_config_entity_ui_swaps_alter(array &$swaps): void {
  $swaps['image_style'] = [
    'Drupal\\my_module\\Entity\\DomainAwareImageStyleStorage',
    'Drupal\\image\\ImageStyleStorage',
  ];
}
```

The tuple is `[domain-aware class, expected current class]`; the strict-equality guard applies the swap only when the type's current storage class matches the expected one. You can also unset an auto-discovered entry here to opt a type out entirely (it then never appears on the settings form).
