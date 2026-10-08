<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Paragraph Delete (bulk_paragraph_delete) — agent index

One admin form that deletes several **Paragraphs types** (`paragraphs_type` config entities) at once. Package `Paragraphs`. Depends on **`paragraphs`**. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

- **The form, route, action link, dependency-skip logic, and how to operate it** →
  [api/bulk-delete-form.md](api/bulk-delete-form.md)

## What it actually is

- One class: `BulkParagraphDeleteForm` (form id **`bulk_paragraph_delete_form`**), in `src/Form/BulkParagraphDeleteForm.php`, extending core `FormBase`. Injects `entity_type.manager` only.
- One route: `bulk_paragraph_delete.form` → `/admin/structure/paragraphs_type/bulk-paragraph-delete`, `_form` = the class, requirement `_permission: 'administer paragraphs'` (the Paragraphs module's admin permission).
- One action link: `bulk_paragraph_delete.action` ("Bulk Delete Paragraphs"), `appears_on: entity.paragraphs_type.collection`.
- **No** own permissions, config, config schema, services, hooks, plugins, or Drush commands.

## Mechanism (from source)

- `buildForm()` loads all `paragraphs_type` config entities and renders a `#type: tableselect` (columns Label / Machine Name / Description) plus a single danger-styled submit button.
- `validateForm()` requires at least one selected type.
- `submitForm()` loads all `field_config` entities once, then for each selected type checks every field's `handler_settings.target_bundles` for the type id. If any field references it, the type is **skipped** with a warning listing `entity_type.bundle.field_name`; otherwise `$paragraph_type->delete()` runs and a deleted counter increments. A status message reports the deleted count; skipped types produce warnings.
- Deletes **config entities (paragraph types)**, not paragraph content entities.
