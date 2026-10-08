Entity Bundle Permissions generates a per-bundle "Access" permission for every content entity type that has bundles, and uses `hook_entity_access()` to forbid any operation on an entity whose bundle the acting user lacks that permission for.

---

The module has no schema of its own beyond a single settings config; its power comes from two pieces. First, `DynamicPermissions::get()` (registered via `permission_callbacks` in `entity_bundle_permissions.permissions.yml`) walks every non-internal content entity type that declares a bundle entity type and emits one permission per bundle named `entity_bundle_permissions access <entity_type> <bundle>` (e.g. `entity_bundle_permissions access node article`). Second, `entity_bundle_permissions_entity_access()` runs for every entity and, when the entity type "applies", returns `AccessResult::forbidden()` unless the account holds that bundle's permission. Crucially the permission only *restricts*: granting it adds no access a user did not already have, but lacking it blocks all operations (view, update, delete) on that bundle. Entity types can be excluded from this behaviour through the `ignored_entity_types` setting on the config form at `/admin/config/entity-bundle-permissions`. When you save that form the module also revokes any now-nonexistent permissions from every role. Applicability requires: a content (not config) entity type, a declared bundle entity type, not internal, and not in the ignored list. There are no plugins, no Drush commands, and no hooks the module invites you to implement.

---

- Restrict which roles may view or edit nodes of a specific content type (e.g. only editors touch `page` nodes).
- Lock down a sensitive media bundle so only a curator role can access those media entities.
- Gate access to a particular taxonomy vocabulary's terms by bundle.
- Add per-bundle access to a custom content entity type without writing a custom access handler.
- Enforce that anonymous users cannot access `private_note` nodes while still allowing other bundles.
- Give a "reviewer" role access to only one content type among many.
- Combine with core role permissions to carve out bundle-scoped editorial teams.
- Exclude the `user` or `taxonomy_term` entity type from bundle gating via the ignored list.
- Prevent a module-provided content type from being reachable until a role is explicitly granted its bundle permission.
- Apply blanket per-bundle access control across every content type after enabling the module.
- Provide a quick way to hide an entire content type from most users by not granting its permission.
- Restrict access to Commerce product variations or other bundled commerce entities by bundle.
- Scope a paragraph bundle's access (where paragraphs expose bundle entity types) to specific roles.
- Ensure new content types are access-restricted by default until permissions are assigned.
- Audit which roles can reach each bundle by reading the generated permission list.
- Remove stale bundle permissions from all roles automatically by resaving the settings form.
- Keep certain infrastructure entity types out of the permission explosion using `ignored_entity_types`.
- Layer bundle-level access on top of node grant modules for finer control.
- Restrict access to a "staff only" content type on an intranet site.
- Enforce least-privilege access where each role only reaches the bundles it needs.
- Temporarily block a bundle site-wide by revoking its permission from all roles.
- Model per-department content visibility where each department maps to a content type.
- Provide bundle-scoped access to block content types (`block_content`) so only some roles manage certain custom block types.
- Deploy the `ignored_entity_types` config through configuration management to standardise exclusions across environments.
