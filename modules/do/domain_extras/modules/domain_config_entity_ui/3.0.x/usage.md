Extends domain_config_ui to config *entity* admin pages (blocks, view modes, search pages, views, …) so their list builders and edit forms show the active domain's per-domain overrides instead of the override-free base values. (experimental)

---

This experimental submodule fills the gap domain_config_ui leaves: the parent covers `ConfigFormBase` settings forms, but config *entities* are read override-free on admin paths, so a block/view-mode/search-page list builder or edit form renders base values even when the active domain has an override. It works by swapping the `storage_class` of selected config entity types for a domain-aware drop-in. `DomainAwareSwapRegistry` auto-discovers every config entity type whose default storage handler is core's `ConfigEntityStorage` and maps it to `DomainAwareConfigEntityStorage` (a thin `ConfigEntityStorage` subclass using `DomainAwareConfigEntityStorageTrait` and implementing the marker `DomainAwareConfigEntityStorageInterface`); contrib can register siblings for types with custom handlers (image_style, user_role, menu) via `hook_domain_config_entity_ui_swaps_alter()`. Coverage has two opt-in layers: installing the module, and per-type checkboxes on the settings form (`SettingsForm`, route `domain_config_entity_ui.settings_form` at `/admin/config/domain/config-entity-ui`, permission `administer domain config entity ui`), stored in `domain_config_entity_ui.settings.covered_entity_types`. `DomainConfigEntityUiEntityTypeHooks::entityTypeAlter()` (`hook_entity_type_alter`) applies the swap for covered types with a strict-equality guard that preserves any custom storage class; `DomainConfigEntityUiSettingsSubscriber` clears entity-type definitions on settings save so changes take effect without a manual `drush cr`. The trait's `doLoadMultiple()` folds the active domain's registered override onto override-free reads only (regular loads, saves, CLI are untouched); `DomainOverrideConfigEntityConverter` (service `domain_config_entity_ui.paramconverter.configentity_admin`, priority 10, extends core's `AdminPathConfigEntityConverter`) loads override-merged entities on admin edit routes for covered, registered configs; and `DomainConfigEntityUiFormHooks::formAlter()` exposes the parent's "Enable domain configuration" toggle on `EntityForm`-based edit pages by calling `DomainConfigUiFormHooks::enableDomainConfigForm()`. Requires `domain:domain_config_ui`; core 10.3+/11.

---

- Show per-domain block config on the block list and block edit forms.
- Make config-entity list builders honor the active domain's overrides.
- Let a domain editor edit a view mode / search page and see that domain's values.
- Pick exactly which config entity types get per-domain support (checkbox list).
- Toggle "Enable domain configuration" on config-entity edit forms, like domain_config_ui does for settings forms.
- Auto-discover coverable config entity types (default `ConfigEntityStorage` handler).
- Register a custom entity type's swap via `hook_domain_config_entity_ui_swaps_alter()`.
- Remove an auto-discovered type from coverage in that same alter hook.
- Ship a sibling `DomainAware*Storage` subclass to cover image styles, roles, or menus.
- Apply swaps only to types matching the expected current storage class (preserves contrib subclasses).
- Change coverage and have it take effect on the next request (no manual cache rebuild).
- Keep saves, runtime renders, and drush reads on the vanilla override stack.
- Merge only the active domain's registered, allowed override onto override-free reads.
- Gate the domain toggle to entity types whose storage is domain-aware.
- Configure coverage at `/admin/config/domain/config-entity-ui` with `administer domain config entity ui`.
- Pair with domain_config_ui to cover both settings forms and config entities.
- Detect coverage in code via `DomainAwareConfigEntityStorageInterface`.
- Enumerate available swaps programmatically with `DomainAwareSwapRegistry::getSwaps()`.
