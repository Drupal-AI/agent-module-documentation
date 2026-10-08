<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Type Clone gives administrators two admin forms that duplicate a **bundle** (content type, vocabulary, block type, paragraph type, profile type, storage type) together with its fields and displays, or duplicate a **user role** with all of its permissions.

---

The module is two forms plus a batch worker. `/admin/config/entity-type-clone` (route `entity_type_clone.type`, the module's `configure` route) shows an AJAX-driven *entity type → bundle* pair of selects and a target bundle name, machine name and description; `/admin/config/role-clone` (route `entity_type_clone.role`) shows a role select plus a new label and machine name. Both are gated by the single permission `access entity type clone`, and the module also injects a "Clone *X*" operation into the bundle list builders of node, paragraph, taxonomy term and profile via `hook_entity_operation_alter()`. Cloning runs as a Drupal batch: the first operation, `CloneEntityType::cloneEntityTypeData()`, creates the target bundle — `createDuplicate()` with a fresh UUID for node/paragraph/block_content types, a plain `create()` for vocabularies, profile types and storage types — and then re-applies the source's extra-field visibility to every matching view display. One further operation per field runs `CloneEntityType::cloneEntityTypeField()`, which duplicates each bundle-level `FieldConfig` onto the new bundle (skipping fields already added by another module, non-entity field definitions, and taxonomy's `parent`) and then copies each enabled form mode and view mode display, string-replacing the old bundle machine name with the new one throughout the display config. Role cloning is simpler: it creates the new `user_role` entity and calls `user_role_grant_permissions()` with the source role's permission list. The module ships no config, no schema, no services, no Drush commands and no plugin types; the on-screen note warns you to review a cloned bundle before exporting config or creating content in it.

---

- Spin up a "Landing page" content type from an existing "Basic page" with all its fields intact.
- Duplicate a heavily-fielded Article type as the starting point for a new section of the site.
- Clone a vocabulary so a second taxonomy has the same fields without rebuilding them.
- Copy a Paragraph type (when Paragraphs is installed) to create a variant component.
- Duplicate a custom block type together with its fields and displays.
- Clone a Profile type (Profile module) for a second profile variant.
- Create an "Editor (restricted)" role by cloning "Editor" and then removing a few permissions.
- Give a client a copy of an existing role to tweak rather than reassembling permissions.
- Reproduce a bundle's Manage form display and Manage display layout in one step.
- Carry field-group and other third-party view-display settings across to the clone.
- Preserve which extra fields (links, title, etc.) are visible in each view mode of the clone.
- Prototype a content model variant quickly during a discovery workshop.
- Build per-brand content types on a multi-brand site from a shared template type.
- Set up staging/test bundles that mirror production ones for QA.
- Use the "Clone" operation link on the content types listing instead of the standalone form.
- Duplicate a bundle before a risky refactor so you can compare configurations.
- Create a bundle whose fields must exactly match an existing one for a migration target.
- Bootstrap a new storage type (Storage module) from an existing one.
- Avoid hand-editing dozens of `field.field.*` YAML files to add a near-identical bundle.
- Restrict who can clone by granting only trusted roles `access entity type clone`.
- Clone a content type and then adjust only the description and label for a sister site section.
- Reduce site-building time when several content types share the same 15-field structure.
- Regenerate a bundle after an accidental deletion using a similar existing bundle as the base.
