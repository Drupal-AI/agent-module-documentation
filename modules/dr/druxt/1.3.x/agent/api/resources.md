<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model, resource list & the alter hook

All in `druxt.module` unless noted. This is how DruxtJS decides what a frontend may read.

## Permissions

`druxt.permissions.yml`:
- `access druxt resources` — read the exposed JSON:API resources. Intended for the role the Nuxt
  frontend uses (commonly anonymous).
- `administer druxt` — `restrict access: true`; configure the resource list (form only).

## The list functions

- `druxt_default_resources()` — the twelve resources shipped in `config/install`, hardcoded here too
  so a not-yet-configured or not-yet-updated site still serves a frontend.
- `druxt_grandfathered_resources()` — `['menu_link_content--menu_link_content']`, the one content
  resource allowed for backward compatibility.
- `druxt_resource_is_allowed($resource)` — TRUE for a grandfathered resource or one whose entity type
  `entityClassImplements(ConfigEntityInterface::class)`. Governs what the **form offers** and what the
  **validation constraint accepts**.
- `druxt_resource_is_permitted($resource)` — wider: TRUE also when the entity type is **not installed**
  here (no route exists, so nothing is granted, and a shared config set can name a resource this site
  lacks). Governs what may be **stored and granted** at runtime.
- `druxt_resources()` — stored list (or defaults) → `array_filter(..., druxt_resource_is_permitted(...))`
  → `hook_druxt_resources_alter()`. The runtime source of truth; the filter re-checks stored config
  every time rather than trusting it.

## The access grants

For a request, `druxt_access_check(AccountInterface $account)`:
1. there is a route object;
2. it is a JSON:API request (`Routes::isJsonApiRequest($defaults)`);
3. its `resource_type` is in `druxt_resources()`;
4. it is a **GET**;
5. the account has `access druxt resources`.

Consumers of that check:
- `druxt_entity_access()` (`hook_entity_access`) — returns `AccessResult::allowed()` when the check
  passes, else `AccessResult::neutral()`; adds a cacheable dependency on `druxt.settings`.
- `druxt_jsonapi_entity_filter_access()` (`hook_jsonapi_entity_filter_access`) — when the check
  passes, returns `AMONG_ALL => AccessResult::allowed()` (with the same config dependency) so the
  frontend may filter the resource; otherwise `NULL` (no opinion).
- `DruxtRequestPath::evaluate()` (`Plugin/Condition/DruxtRequestPath`, swapped in for core
  `request_path` via `hook_condition_info_alter`) — returns `!isNegated()` when the check passes so a
  block's path-visibility condition resolves for a DruxtJS request, else defers to the parent.

Because the answer depends on `druxt.settings`, every grant carries a cacheable dependency on that
config so caches invalidate when the list changes.

## Extending the list in code — `hook_druxt_resources_alter()`

Documented in `druxt.api.php`. `hook_druxt_resources_alter(array &$resources)` runs **after** the
permitted-filter, so code can expose anything (including a content entity type the form/constraint
refuse) or remove a default. Signature example: `$resources[] = 'my_module_settings--my_module_settings';`
or `$resources = array_values(array_diff($resources, ['menu_link_content--menu_link_content']));`.
Prefer this over the form when a module knows the resource it needs, so installing the module is all a
site must do.

## Validation constraint

`DruxtResourceConstraint` (id `DruxtResource`) + `DruxtResourceConstraintValidator`
(`src/Plugin/Validation/Constraint/`). The validator returns early for empty values and grandfathered
resources, returns early (no violation) for an entity type not installed here, and otherwise adds a
violation unless `druxt_resource_is_allowed()`. Applied via the config schema on `resources` items and
enforced by the settings form and by `DruxtConfigImportSubscriber` (Drupal does not run schema
constraints on save/import on its own).

## Install-time behaviour

- `druxt_entity_bundle_create()` (`hook_entity_bundle_create`) — creates the bundle's default entity
  view display (unless config is syncing).
- `druxt_ensure_entity_view_displays()` / `druxt_ensure_entity_view_display()` — create any missing
  `entity_view_display` config entities across fieldable entity types; run by `druxt_install()` and
  `druxt_update_9000()`.
- `druxt_update_10301()` — installs the module's default config (moves the hardcoded list into config).
