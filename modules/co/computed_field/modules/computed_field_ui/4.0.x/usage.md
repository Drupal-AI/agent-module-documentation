Computed Field UI is the admin interface submodule of Computed Field: it lets site builders add and manage computed fields through the standard Field UI, without writing code. It depends on `computed_field` and core `field_ui`.

---

Enabling this submodule adds an **"Add computed field"** local action to every bundle's "Manage fields" page (route `entity.computed_field.computed_field_add_{entity_type}`, path `{field_ui_base}/fields/add-computed-field`, e.g. `/admin/structure/types/manage/article/fields/add-computed-field`). The add form asks for a label and lets the admin pick one of the available computed field plugins (those without `no_ui`); configurable plugins render their own sub-form. Saving creates a `computed_field` config entity (field name prefixed per `computed_field.settings:field_prefix`, default `computed_`) and sets a default view-display formatter. The submodule also provides edit and delete forms wired into the Field UI, and a **"Computed fields"** report at `/admin/reports/fields/computed` (route `entity.computed_field.collection`) listing all computed fields on the site. All of this is gated by the `administer computed_field entities` permission. It provides no config of its own — it is purely the management UI over the parent module's plugins and config entities.

---

- Add a computed field to a content type from the "Manage fields" screen, no code required.
- Pick a computed field plugin (e.g. `reverse_entity_reference`) and configure it via a form.
- Give the new computed field a human-readable label and auto-prefixed machine name.
- Edit an existing computed field's label or plugin configuration in the UI.
- Delete a computed field through the standard Field UI delete form.
- Browse every computed field on the site from the "Computed fields" report page.
- Position a computed field in Manage Display like any other field.
- Let non-developers self-serve computed fields once a developer has provided the plugins.
- Restrict who can manage computed fields with the `administer computed_field entities` permission.
- Expose computed fields on any Field-UI-enabled entity type (nodes, users, terms, media, …).
- Add a bundled `reverse_entity_reference` field (list back-references) without touching code.
- Audit which bundles carry computed fields from the central report page.
- Rename or relabel a computed field after creation without a code deploy.
- Prototype a computed field in the UI, then export its config entity for version control.
- Choose among several developer-provided computed field plugins per field.
- Keep computed fields out of the add form by marking their plugin `no_ui` (managed upstream).
- Confirm a computed field's underlying field type via its Field UI listing.
- Hand off field creation to site builders while developers own the plugin logic.
- Manage computed fields on custom entity types that opt into Field UI.
- Remove a stale computed field cleanly through the delete confirmation form.

