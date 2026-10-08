<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Administrative UI for creating and managing API Sync mappings, field maps, mapped objects, and mapped-object types.

---

`apisync_mapping_ui` adds the admin interface on top of `apisync_mapping`. Under `/admin/structure/apisync/mappings` it provides list builders and CRUD forms for `apisync_mapping` entities (add/edit/delete/enable/disable) plus a dedicated fields form for building per-field mappings (choosing an `apisync_mapping_field` plugin and its settings per row). Under `/admin/content/apisync` it lists and edits `apisync_mapped_object` records and their types, with an autocomplete controller for selecting the referenced Drupal entity and an optional Views-based listing. A route subscriber and local task/action/contextual links wire everything into the admin menu. All routes are gated by the restricted mapping permissions (`administer apisync mapping`, `administer apisync mapped objects`, `administer apisync mapped object type`). It depends only on `apisync_mapping`.

---

- Create, edit, delete, enable, and disable API Sync mappings via the admin UI.
- Build per-field mappings on a dedicated fields form (add/remove field rows).
- Select the field-mapping plugin and configure each field row.
- List all mappings with a list builder.
- Create and edit mapped objects and mapped-object types.
- List mapped objects (list builder and optional Views view).
- Autocomplete the referenced Drupal entity when creating a mapped object.
- Add local tasks/actions/contextual links for mapping management.
- Manually create, edit, view, or delete a mapped object for troubleshooting.
- Manage mapped-object types (bundles) through Field UI.
- Gate all management screens behind restricted API Sync permissions.
- Provide the operator-facing counterpart to the programmatic `apisync_mapping` model.
