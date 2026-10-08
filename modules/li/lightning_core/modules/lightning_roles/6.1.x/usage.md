Lightning Roles (submodule of Lightning Core) auto-generates responsibility-based user roles for every content type — e.g. a "creator" and a "reviewer" role per node type — with a template of permissions applied to that type.

---

Lightning Roles defines **content roles** as templates in `lightning_roles.settings` (`content_roles.*`). Each template has an `enabled` flag, a `label`, and a list of `permissions` in which the `?` token stands for a node type ID. When a node type is created (`hook_node_type_insert`), the module creates one `user_role` per enabled template named `{node_type}_{role_key}` (e.g. `article_creator`), replacing `?` in each label/permission with the node type's id/label and granting only the permissions that actually exist. Deleting a node type deletes its generated roles. Out of the box it ships two templates: **creator** (create/edit-own, view revisions, in-place editing, contextual links, toolbar, url aliases) and **reviewer** (access content overview, edit-any, delete-any). Admins edit the templates at `/admin/config/system/lightning/roles` (route `lightning_roles.settings`, under the Lightning menu). The internal `ContentRoleManager` service can add permissions to a template and back-fill them onto existing per-type roles. Config schema lives in `lightning_roles.schema.yml`; the module adds no permissions, plugins, or Drush commands of its own.

---

- Automatically create a "creator" role for each content type with type-scoped create/edit permissions.
- Automatically create a "reviewer" role for each content type with overview/edit-any/delete-any permissions.
- Keep per-content-type roles in sync: new node types get roles, deleted node types lose them.
- Define your own content-role template (e.g. "publisher") in `lightning_roles.settings`.
- Use the `?` token so one permission template (`create ? content`) expands per node type.
- Enable or disable a content-role template so it is or isn't deployed to node types.
- Edit content-role templates in the UI at `/admin/config/system/lightning/roles`.
- Grant an editorial team create/edit-own rights on articles without hand-building roles.
- Give reviewers edit-any / delete-any on a content type in one step.
- Bulk-add a permission to a template and back-fill it onto all existing per-type roles (via `ContentRoleManager`).
- Standardize role naming across content types (`{type}_creator`, `{type}_reviewer`).
- Bootstrap a new site's editorial roles automatically as content types are added.
- Scope "access in-place editing", "access contextual links" and "access toolbar" to creators.
- Grant "view own unpublished content" and "view ? revisions" to content creators.
- Restrict content-role editing UI to administrator-role users (`_is_administrator`).
- Remove default creator/reviewer permissions you don't want by editing the template.
