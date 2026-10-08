<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assignments (assignments) — agent index

A scaffold-generated base module that defines a custom **content entity** `assignment` and its
**config-entity bundle type** `assignment_type`, administered entirely from the Drupal admin UI.
Package `assignments`. Core requirement `^10 || ^11`. PHP `^8.1`. License GPL-2.0-or-later.
Version 4.1.0. **No dependencies** beyond core (`user`, and `views` for the Views-data handler),
no services, no external calls, no Drush.

- **The `assignment` content entity — base fields, storage, access, routes, forms, templates,
  and scaffold quirks** → [entities/assignment.md](entities/assignment.md)
- **Bundles (`assignment_type`), permissions, and config schema** →
  [config/types-and-permissions.md](config/types-and-permissions.md)

## What it actually is (from source)

- **Content entity** `assignment` (`src/Entity/Assignment.php`, `@ContentEntityType`): base_table
  `assignment`, admin_permission `administer assignment entities`, `bundle_entity_type =
  assignment_type`, `field_ui_base_route = entity.assignment_type.edit_form`. Handlers: storage
  `AssignmentStorage` (bare `SqlContentEntityStorage` subclass), `EntityViewBuilder`,
  `AssignmentListBuilder`, `AssignmentViewsData`, `AssignmentAccessControlHandler`,
  `AssignmentHtmlRouteProvider`. Forms: `AssignmentForm` (add/edit), `AssignmentDeleteForm`.
- **Config entity** `assignment_type` (`src/Entity/AssignmentType.php`, `@ConfigEntityType`):
  `ConfigEntityBundleBase`, config_prefix `assignment_type`, admin_permission `administer site
  configuration`, `config_export = {id, label}`. Forms `AssignmentTypeForm`,
  `AssignmentTypeDeleteForm`; list builder `AssignmentTypeListBuilder`.
- **Base fields** (`baseFieldDefinitions`): `user_id` (entity_reference → user, author),
  `name` (string, **labelled "Channel"**, max 50, required), `created`, `changed`. Author defaults
  to current user in `preCreate`.
- **Permissions** (`assignments.permissions.yml`): `add` / `edit` / `delete` /
  `view published` / `view unpublished` / `administer assignment entities` (the last
  `restrict access: true`).
- **Routes** are entity-derived (no `*.routing.yml`): `/admin/content/assignment[...]` for the
  content entity, `/admin/structure/assignment_type[...]` for the bundle. Menu/task/action links
  in `assignments.links.*.yml`.
- **Hooks** (`assignments.module`): `hook_help`, `hook_theme` (themes `assignment`,
  `assignment_content_add_list`), `hook_theme_suggestions_assignment`,
  `hook_preprocess_entity_add_list` (rewrites add-links to carry a `?node=<nid>` query).
- **Config schema**: `config/schema/assignment_type.schema.yml`.

## Access model (summary)

`view` → `view published assignment entities` (or `view unpublished …` when unpublished);
`update` → `edit …`; `delete` → `delete …`; create → `add …`
(`src/AssignmentAccessControlHandler.php`). All operations are permission-gated in the standard
Drupal way; bundle CRUD needs `administer site configuration`.

## Caveats worth knowing (scaffold leftovers)

- `Assignment::isPublished()` is hardcoded to `TRUE` and `setPublished()` is a no-op, so the
  `status` entity key never reflects an unpublished state — everything reads as published.
- `AssignmentForm::buildForm()`/`save()` reference a **`node`** form widget/field that this
  module's entity does not define (leftover coupling to an extension); the settings form class
  `AssignmentSettingsForm` exists but its route is **never registered** (the provider only adds it
  for entity types without a bundle entity, which `assignment` has), so `configure` is null.
- See [entities/assignment.md](entities/assignment.md) for the details.
