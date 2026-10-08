<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Type Permissions generates per-entity-type / per-bundle access permissions for content entities and enforces them through `hook_entity_access()`, with a settings form to pick which entity types are governed.

---

Entity Type Permissions is a small fork of Entity Bundle Permissions that adds granular access permissions to any content-based entity type. On its settings form (`/admin/config/system/entity-type-permissions`) you select which entity types should have permissions generated; for each selected entity type the module's `DynamicPermissions::get()` callback creates one "Access" permission per bundle (for example *Access Content items "Article"*), grouped by base entity type and then by bundle. The `entity_type_permissions_entity_access()` hook then checks the matching per-bundle permission: it returns `AccessResult::allowedIf($account->hasPermission(...))` for governed entity types and stays neutral for everything else, so it participates in Drupal's normal access combination rather than replacing it. Entity types that are not selected on the settings form generate no permissions and are not access-checked, and unchecking an entity type revokes its generated permissions from every role and clears them from configuration — so there is no leftover "reverse permission" cleanup. The module depends only on core User and ships no config schema, Drush commands, or plugin types.

---

- Add granular per-bundle access permissions to content nodes without a heavier access module.
- Restrict which roles may access a specific content type (e.g. only editors reach "Article" entities).
- Generate per-bundle permissions for Media types (e.g. *Access Media items "Image"*).
- Generate per-bundle permissions for Comment types.
- Generate per-bundle permissions for Taxonomy vocabularies (terms).
- Generate per-bundle permissions for custom content entity types that declare a bundle entity type.
- Pick exactly which entity types get permissions so the People → Permissions page stays short.
- Avoid generating permissions for entity types you do not need to govern.
- Revoke and remove an entity type's generated permissions from all roles by unchecking it on the settings form.
- Group the permissions list by base entity type (Content, Comment, Media) and then by bundle for easier scanning.
- Assign the generated per-bundle permission to a role on People → Permissions.
- Combine the module's per-bundle permission with core permissions (such as "View published content") to shape what a role can do.
- Gate access to a newly created content type for a specific role.
- Manage access for many bundles across several entity types from one settings screen.
- Limit configuration of the module itself with the "Administer Entity Type Permissions settings" permission.
- Run the module on PHP 7.4 or PHP 8 sites.
- Use it on Drupal 8, 9, 10, or 11.
- Replace the older Entity Bundle Permissions workflow with a settings-driven one.
- Keep permission generation scoped to non-internal content entity types that have bundles.
- Enforce access per bundle across all entity operations for that bundle.
- Configure the governed entity-type set through exported configuration (`entity_type_permissions.settings` → `permissions_filter`).
