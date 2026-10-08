<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attempt entity & attempt types

## Content entity: `attempt_mgmt_attempt`
`src/Entity/Attempt.php` — `final class Attempt extends ContentEntityBase` (uses `EntityChangedTrait`, `EntityOwnerTrait`).

- `base_table = attempt_mgmt_attempt`, `admin_permission = "administer attempt_mgmt_attempt types"` (governs all CRUD; there is no custom access handler).
- `bundle_entity_type = attempt_mgmt_attempt_type` (config bundle, below).
- `entity_keys`: id, bundle, uuid, owner=`uid`.
- Handlers: list builder `AttemptListBuilder`; `views_data` = core `EntityViewsData`; forms add/edit = `AttemptForm`, delete = core `ContentEntityDeleteForm`; route provider `Routing\AttemptHtmlRouteProvider`.
- Links: `collection` `/admin/content/attempt`, `add-page` `/attempt/add`, `add-form` `/attempt/add/{type}`, `canonical`/`edit-form` `/attempt/{attempt_mgmt_attempt}`, `delete-form`, `delete-multiple-form`. `AttemptHtmlRouteProvider::getCanonicalRoute()` returns the edit-form route, so the canonical path shows the edit form.

### Base fields (`baseFieldDefinitions()`)
- `status` (boolean, default FALSE) — the graded/active flag.
- `uid` (entity_reference → user) — owner/author.
- `entity_type` (string, max 32) — host entity type machine name.
- `entity_id` (integer, unsigned) — host entity id.
- `created` / `changed` (created/changed) — "Attempt started" / "Attempt updated".
- `duration` (string) — computed `%D:%H:%I:%S` from created→changed (see `setDuration()`).
- `temporary` (boolean, default TRUE) — an in-progress attempt not yet counted.
- `closed` (boolean, default FALSE) — finished attempt.
- `number_attempt` (integer, unsigned) — the user's Nth attempt.
- `ip` (string) — set in `preCreate()` from `\Drupal::request()->getClientIp()`.
- `session_uuid` (string) — identifies an anonymous visitor's attempts (see `getSessionUuid`/`setSessionUuid`).

### Lifecycle
- `preCreate()` seeds `ip` with the client IP.
- `preSave()` sets the owner to the anonymous user (uid 0) when none is set, and recomputes `duration` when `created < changed`.

## Config bundle entity: `attempt_mgmt_attempt_type`
`src/Entity/AttemptType.php` — `final class AttemptType extends ConfigEntityBundleBase`.
- `bundle_of = attempt_mgmt_attempt`, `config_prefix = attempt_mgmt_attempt_type`, `admin_permission = "administer attempt_mgmt_attempt types"`.
- `config_export`: id, label, uuid (schema `attempt_mgmt.attempt_mgmt_attempt_type.*`).
- Managed at `/admin/structure/attempt_mgmt_attempt_types` (add / manage / delete); forms `AttemptTypeForm`, list builder `AttemptTypeListBuilder`, core `AdminHtmlRouteProvider`.
- `field_ui_base_route = entity.attempt_mgmt_attempt_type.edit_form` — attempt types get a Field UI (Manage fields/display) so you can add fields to attempts per type (e.g. score).

## Operating
1. Enable the module (`ddev drush en attempt_mgmt -y`).
2. Create at least one attempt type at `/admin/structure/attempt_mgmt_attempt_types/add`.
3. Add extra fields to the type via Field UI if you need to store results (score, etc.).
4. Attach the [attempt settings field](../fields/settings-field.md) to the host entity, or drive creation through the [AttemptFactory API](../api/factory.md).

Two entity actions ship in config: `attempt_mgmt_attempt_save_action` and `attempt_mgmt_attempt_delete_action` (bulk save/delete on the collection). An optional REST resource (`config/optional/rest.resource.entity.attempt_mgmt_attempt.yml`, cookie auth, GET/POST/PATCH/DELETE) is installed only when the REST module is enabled; it still enforces entity access.
