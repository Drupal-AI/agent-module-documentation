<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Data

Defines a general-purpose fieldable content entity type (`custom_data`) with user-defined bundles ("custom data types"), so you can store structured data as its own entity rather than as nodes.

- Each custom data type is a config entity; items are content entities with fields, an owner, published status, and revisions.
- Types can optionally expose a canonical URL at `/custom-data/{id}`.
- Uses the contrib `entity` module's query-access and permission-provider handlers for granular access.

---

## Installation & configuration

- Requires the contrib **Entity API** (`entity`) module plus core field/options/text/user.
- Enable, then manage types at `/admin/structure/custom-data-type` (`entity.custom_data_type.collection`).
- Permissions include `administer custom_data`, `administer custom_data_type` (restricted), and `access custom_data overview`.
- Per-bundle permissions are generated via the Entity API `UncacheableEntityPermissionProvider` (granularity = bundle).
- Enable **canonical URLs** per type to make items viewable at `/custom-data/{id}`.
- Add fields to each type through the normal field UI.

---

## Usage & behaviour

- The canonical route `entity.custom_data.canonical` is guarded by `CustomDataController::viewCanonicalAccess`.
- Access properly delegates to `$entity->access('view', $account, TRUE)` and honours the type's canonical flag.
- If a type has no canonical URL, viewing returns 404 (or redirects the item's editor to the edit form).
- Entity queries in the module use `->accessCheck(TRUE)`.
- The overview page is gated by `access custom_data overview`.
- String representation of an item can be customised via `hook_custom_data_get_string_representation` (see `custom_data.api.php`).
- Items support revisions; the "Administer custom data" permission can override the new-revision default.
- Tokens are provided via `custom_data.tokens.inc`.
- Templates live in `templates/`; theme hook `custom_data` (render element `elements`).
- The entity classes live under `src/Entity/`.
- Admin-permission checks guard the canonical/permissions toggle in the type form.
- Use this instead of nodes when the data is not "content pages" but structured records.
- Bundle-level access control means you can grant view/edit per type.
- No SSRF, external fetch, or unauthenticated mutation surface — access is entity-access driven.
- Uninstall removes the entity type and its data.
