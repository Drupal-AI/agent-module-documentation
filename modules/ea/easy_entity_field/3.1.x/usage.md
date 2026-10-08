<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Entity Base Field lets site builders add fields to a content entity type's base table (base/bundle fields) through a Field UI-like interface, instead of hand-coding `hook_entity_base_field_info()`.

---

You first choose, on the settings form (`/admin/config/development/easy-entity-field`, route `easy_entity_field.settings_form`), which entity types to enable and where their "Manage Base Fields" tab attaches. The module's `RouteSubscriber` then generates per-entity-type routes (`.../base-field`, `/add`, `/{field}/storage`, `/{field}`, `/{field}/delete`) mirroring Field UI, and an `EasyEntityUpdate` service applies the resulting field storage definitions to the entity's schema via the entity definition update manager. Field plugins (`EntityReference`, `EntityReferenceRevisions`, `DynamicEntityReference`) supply the widgets/config for reference-type base fields. A config entity `easy_entity_field` records each managed field so it can be listed, edited, or cleaned up; an uninstall validator blocks removing the module while managed fields still exist.

Because adding or altering a base field is effectively a schema change, every route is gated behind restricted permissions: the global `administer easy entity field` (`restrict access: TRUE`) plus dynamically generated, per-entity-type `administer <entity_type> base fields` permissions (also `restrict access: TRUE`, from `EasyEntityFieldPermissions`). There are no anonymous, low-privilege, or mutating public endpoints — field creation is admin-only. Typical setup: enable the module and Field UI, select target entity types on the settings form, then use the generated "Manage Base Fields" tab to add fields.
---
- Add a base field to the `node` entity without custom code.
- Add a field to a custom content entity's base table.
- Enable base-field management for a chosen entity type on the settings form.
- Create an entity reference base field via the reference plugin.
- Create a dynamic entity reference base field.
- Create an entity reference revisions base field.
- Edit an existing managed base field's settings.
- Adjust field storage settings for a base field.
- Delete a managed base field and clean up its schema.
- List all base fields managed by the module.
- Apply the new field definitions to the entity schema automatically.
- Attach the "Manage Base Fields" tab to an entity type's existing UI.
- Grant a specific team the `administer <type> base fields` permission.
- Restrict base-field administration with per-entity-type permissions.
- Remove orphaned field definitions left after a config change.
- Prevent module uninstall while managed base fields still exist.
- Prototype an entity data model quickly during development.
- Extend the plugin set with a custom base-field type plugin.
- Reference the settings config entity in deployment/config sync.
