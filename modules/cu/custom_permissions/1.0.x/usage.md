Custom Permissions lets an administrator define named permission strings through an admin UI and have each one automatically registered with Drupal's permission system for use in roles, Views, and other modules.

---

The module ships a single config entity type, `custom_permissions`, managed at `/admin/people/custom-permissions`. Each entity has a label, a machine name (id), a description, and an enabled/disabled status. A dynamic permission callback (`PermissionBuilder::buildPermissions`) walks every enabled entity and emits a permission whose key is the entity's machine name and whose title reads "Custom Permissions: <label>". Those permissions then appear on the standard `People → Permissions` page (`/admin/people/permissions`) where they can be granted to roles, and they become selectable anywhere core resolves permissions — most usefully as a Views access requirement. The intended audience is site builders and front-end developers who need a new permission to gate a View or a route but do not want to write a `.permissions.yml` file or a custom module. All create/edit/delete operations are gated by the module's own `administer custom_permissions` permission; the module never assigns permissions to roles itself, so role assignment still goes through core's usual permissions page. There is no settings form, no external service, no Drush command, and no dependency beyond Drupal core.

---

- Define a new permission from the UI without writing a `.permissions.yml` file or a custom module.
- Create a permission used as the "access" requirement of a View.
- Gate a Views page or block display behind a purpose-built permission.
- Add a permission that a Rules/ECA or Flag configuration can check.
- Give a client a self-service way to mint project-specific permission names.
- Standardize permission naming across a multi-site build by defining them centrally.
- Temporarily disable a custom permission (set status to Disabled) so it stops being offered, without deleting its definition.
- Provide a descriptive help text for each permission via the entity description field.
- Rename the human-readable title of a permission by editing its label (the machine name stays fixed once created).
- List all site-defined custom permissions and their enabled/disabled state on one admin page.
- Delete a custom permission that is no longer needed via a confirm form.
- Export custom-permission definitions through Drupal's configuration management (they are config entities).
- Deploy a set of predefined permissions between environments by syncing configuration.
- Let a non-developer content team introduce a new access boundary without a code deployment.
- Create a permission to expose to a contrib module that reads Drupal's permission list.
- Add a permission that a menu or route access check (`_permission`) can reference.
- Group related access needs under clearly labelled "Custom Permissions: …" entries on the permissions page.
- Prototype an access model quickly, then later replace the custom permissions with hard-coded module permissions.
- Keep permission definitions under version control as exported YAML config.
- Audit which ad-hoc permissions exist on a site by reviewing the custom permissions collection.
