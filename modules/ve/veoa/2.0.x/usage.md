Views Entity Operation Access (VEOA) is a Views access-control plugin that grants access to a view only if the current user may perform a chosen entity operation (view/update/delete/…) on an entity taken from the view's path.

---

VEOA provides one Views access plugin, `veoa_entity_access_operation` ("Entity Operation", `src/Plugin/views/access/EntityOperation.php`). On a view's page display you set its *Access* to "Entity Operation" and configure three options: `parameter` (the path argument that holds the entity, e.g. `%node` in `node/%node/edit`), `entity_type` (chosen from the site's entity types), and `operation` (a string such as `view`, `update`, `create`, `delete`). Rather than checking access at request time in `access()` (which just returns whether the config is valid), the plugin implements `alterRouteDefinition()`: when the view is saved it upgrades the named path parameter to an entity parameter (`type: entity:<entity_type>`, enabling entity param-upconversion) and adds a core route requirement `_entity_access: <entity_type>.<operation>`. Drupal core then enforces that requirement on every request, so the view is only reachable when the user has that operation's access on the up-cast entity in the path. This lets a view page inherit the exact access rules of an entity operation (respecting entity access handlers, hook_entity_access, etc.) instead of a flat permission or role check. The module ships a config schema for the three options, has no permissions of its own, no settings page, and no Drush commands. Because the check is wired as a route requirement, the entity parameter must exist in the display's path for access to resolve.

---

- Restrict a view page to users who can **view** a specific entity taken from the path.
- Gate a custom entity-edit-style view behind the entity's **update** access.
- Gate a view behind **delete** access for the entity in context.
- Build a "related items" view under `node/%node/…` that only appears if the user can view that node.
- Reuse an entity type's access handler for a view instead of duplicating permission logic.
- Attach an operation-based access check to a view whose path already contains an entity id.
- Respect `hook_entity_access` / access handlers automatically on a view page.
- Create tab-style local task views on an entity that follow that entity's per-operation access.
- Protect a media/user/taxonomy view page by an operation on that entity type.
- Avoid writing a custom access plugin or route subscriber for entity-operation-gated views.
- Ensure a view's path parameter is up-cast to a full entity (param conversion) as a side effect.
- Combine with core Views to expose data only to users allowed to act on the contextual entity.
- Gate a view under `user/%user/…` on **update** access so only profile owners/admins reach it.
- Restrict a taxonomy-term listing view to users who can view that term.
- Enforce operation access on a view without granting an extra site-wide permission.
- Ensure moderators only see an entity-scoped view when they can act on that entity.
- Wire consistent access between an entity's canonical page and a companion view page.
- Configure per-operation access for media or custom-entity view pages.

