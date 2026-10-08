# Domain Configuration Entity UI (domain_config_entity_ui) 3.0.x

![Domain Config Entity Types settings form (/admin/config/domain/config-entity-ui)](../../../../../../../../screenshots/domain_config_entity_ui/3.0.x/settings.png)

Extends domain_config_ui to config **entity** admin pages so list builders and edit forms honor the active domain's per-domain overrides. **Lifecycle: experimental** (`lifecycle: experimental` in info.yml; issue [#3588091](https://www.drupal.org/project/domain_extras/issues/3588091)).

## Facts

- **Dependency:** `domain:domain_config_ui` (the parent module; provides `domain_config_ui.manager` / `DomainConfigUIManagerInterface`, `DomainConfigUiFormHooks`, and `domain.config_factory_override`).
- **Core:** `^10.3 || ^11`. Package: Domain.
- **Route:** `domain_config_entity_ui.settings_form` → `/admin/config/domain/config-entity-ui`, `_form: SettingsForm`, permission `administer domain config entity ui` (`domain_config_entity_ui.routing.yml`). Menu link under `domain.admin` (`*.links.menu.yml`). `configure:` points here.
- **Permission:** `administer domain config entity ui` (`restrict access: true`) — `domain_config_entity_ui.permissions.yml`.
- **Config:** `domain_config_entity_ui.settings` with `covered_entity_types` (sequence of entity-type ids), default empty (`config/install`, `config/schema`).
- **Services** (`domain_config_entity_ui.services.yml`, autowired):
  - `Drupal\domain_config_entity_ui\DomainAwareSwapRegistry` — builds the map of coverable config entity types.
  - `domain_config_entity_ui.paramconverter.configentity_admin` = `ParamConverter\DomainOverrideConfigEntityConverter`, tag `paramconverter` **priority 10** (above core's 5).
  - `Hook\DomainConfigEntityUiEntityTypeHooks`, `Hook\DomainConfigEntityUiFormHooks`, `EventSubscriber\DomainConfigEntityUiSettingsSubscriber`.
- **Hooks** (`#[Hook]` classes, with `#[LegacyHook]` procedural fallbacks in `.module` for D10.6):
  - `hook_entity_type_alter` — `DomainConfigEntityUiEntityTypeHooks::entityTypeAlter()` swaps `storage_class` for covered types.
  - `hook_form_alter` — `DomainConfigEntityUiFormHooks::formAlter()` adds the "Enable domain configuration" toggle to `EntityForm` config-entity edit forms.
  - `hook_domain_config_ui_disallowed_configurations_alter` — same class, marks `domain_config_entity_ui.settings` as never-overridable.
- **Entity storage:** `Entity\DomainAwareConfigEntityStorage` (extends `ConfigEntityStorage`, uses `DomainAwareConfigEntityStorageTrait`, implements marker `DomainAwareConfigEntityStorageInterface`).
- **API:** `hook_domain_config_entity_ui_swaps_alter(array &$swaps)` — register/remove entity-type swaps (`domain_config_entity_ui.api.php`).
- **Provides:** no Drush, no plugin types.

## Setup / How to use

1. Enable the module (pulls in domain_config_ui). Installing it is the coarse opt-in — no runtime swap happens until a type is selected.
2. Go to **Configuration → Domain → Domain config entity types** (`/admin/config/domain/config-entity-ui`) and check the config entity types to cover (e.g. `block`). Only `block` is validated; other auto-discovered types are experimental — test off production. Requires `administer domain config entity ui`.
3. Save — the settings subscriber clears entity-type definitions, so the swap takes effect next request (no manual rebuild).
4. On the covered type's admin/list/edit pages, while browsing a domain that has the config registered as overridable (via domain_config_ui), the active domain's override values now appear, and the "Enable domain configuration" toggle shows on the entity edit form.

## Docs

- [storage-swap.md](storage-swap.md) — how the storage-swap registry, `entity_type_alter`, the override-merging storage trait, the param converter, and the settings form fit together; plus the `hook_domain_config_entity_ui_swaps_alter()` contract.
