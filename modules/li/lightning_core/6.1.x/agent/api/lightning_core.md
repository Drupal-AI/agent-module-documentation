# API — Lightning Core

Programmatic surface. All classes under `Drupal\lightning_core\`.

## Entity descriptions
- `EntityDescriptionInterface` (core interface) — `getDescription()` / `setDescription($s)`.
- `ConfigEntityDescriptionTrait` — trait implementing the interface on top of
  `getThirdPartySetting('lightning_core', 'description')` / `setThirdPartySetting(...)`.
  Reuse it on your own config entity to get the same third-party-setting-backed description.
- Overridden entities (via `hook_entity_type_alter` + `OverrideHelper::entityClass`):
  - `Entity\Role` extends core `user\Entity\Role`, adds description.
  - `Entity\EntityViewMode` — description + `isInternal()` (`internal` third-party setting).
  - `Entity\EntityFormMode` — description + `revision_ui` third-party setting.

## Administrator access check
- Service `access_check.administrator_role` → `Access\AdministrativeRoleCheck`.
  Grants access when the current user has any role whose `is_admin` flag is TRUE.
  Wired to the `_is_administrator` route requirement (`applies_to: _is_administrator`).

## Helper services / utilities
- `lightning.display_helper` → `DisplayHelper` (args: `entity_type.manager`,
  `entity_field.manager`) — read/modify entity **view** displays in code.
- `OverrideHelper` (static) — `entityClass()`, `entityForm()`, `pluginClass()`,
  `entityHandler()`: swap an entity class / form handler / plugin class from a hook.
  This is how Lightning Core rewires core entities and the Views `bundle` filter.
- `Element` — static render-array helpers (e.g. disable/normalize form elements).
- `ConfigHelper`, `DisplayHelper`, `BundleEntityStorage` — config/display convenience.
- `Routing\RouteSubscriber` (`lightning.route_subscriber`) — alters entity routes.
- `Plugin\views\filter\Bundle` + `YieldToArgumentTrait` — a Views exposed **bundle**
  filter that can yield to a contextual argument (adds an `argument` expose option via
  `hook_config_schema_info_alter`).

## Forms (swapped onto core entities)
- `Form\RoleForm` — role add/edit form with a description field.
- `Form\EntityDisplayModeAddForm` / `EntityDisplayModeEditForm`,
  `Form\EntityFormModeAddForm` — display-mode forms exposing description +
  internal / revision-ui toggles. `Form\BulkCreationEntityFormTrait` powers bulk creation.

## No hooks API / no plugin types
Lightning Core defines **no** `*.api.php` hook file and **no** plugin manager of its own.
It *implements* many core hooks (entity_type_alter, entity_base_field_info_alter,
library_info_alter, contextual_links_plugins_alter, etc.) but invites none.
