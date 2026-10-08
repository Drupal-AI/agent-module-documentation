<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk delete form — bulk_paragraph_delete

The module's entire surface is one form. Source: `src/Form/BulkParagraphDeleteForm.php`.

## Install / enable

```bash
composer require drupal/bulk_paragraph_delete
drush en bulk_paragraph_delete -y
```

Requires the **Paragraphs** module (`paragraphs:paragraphs` in `bulk_paragraph_delete.info.yml`). Core `^10.3 || ^11`. No configuration, install config, or schema ships with it.

## Route & access

`bulk_paragraph_delete.routing.yml`:

```yaml
bulk_paragraph_delete.form:
  path: '/admin/structure/paragraphs_type/bulk-paragraph-delete'
  defaults:
    _form: '\Drupal\bulk_paragraph_delete\Form\BulkParagraphDeleteForm'
    _title: 'Bulk Paragraph Delete'
  requirements:
    _permission: 'administer paragraphs'
```

- Access requirement is the Paragraphs module's own `administer paragraphs` permission (a restricted admin permission) — the same permission that governs deleting paragraph types individually.
- Action link `bulk_paragraph_delete.links.action.yml` adds a **"Bulk Delete Paragraphs"** button on `entity.paragraphs_type.collection` (`/admin/structure/paragraphs_type`).
- Being a `FormBase` submit form, Drupal's Form API adds the standard form token, so the POST that performs deletions is CSRF-protected by core.

## Class: `BulkParagraphDeleteForm extends FormBase`

- Constructor injects `EntityTypeManagerInterface` (`entity_type.manager`) via `create()`; no other services.
- `getFormId(): 'bulk_paragraph_delete_form'`.

### `buildForm()`

- Loads `entityTypeManager->getStorage('paragraphs_type')->loadMultiple()`.
- Builds `$form['paragraph_types']` as `#type: tableselect` with header `Label` / `Machine Name` / `Description`, one row per type (`label`, `id`, `getDescription()`), and `#empty` "No paragraph types found."
- `$form['actions']['delete']` is a submit button "Delete Selected Paragraph Types" with `#button_type: 'danger'`.

### `validateForm()`

- `array_filter($form_state->getValue('paragraph_types'))`; if empty, sets an error "Please select at least one paragraph type." (must select ≥1).

### `submitForm()` — the deletion logic

1. `$selected = array_filter(...)` — checked type ids.
2. Loads **all** `field_config` entities once: `getStorage('field_config')->loadMultiple()`.
3. For each selected `$type_id`:
   - Re-loads the `paragraphs_type`; `continue` if it no longer exists.
   - Iterates every `field_config`; if `getSettings()['handler_settings']['target_bundles']` is an array containing `$type_id`, marks it in-use and records `getTargetEntityTypeId().'.'.getTargetBundle().'.'.getName()`.
   - **In use** → pushes a warning "Paragraph type "@type" is used in: @fields" and `continue` (not deleted).
   - **Unused** → `$paragraph_type->delete()`, increment `$deleted`.
4. After the loop: if `$deleted > 0`, adds status "@count paragraph type(s) deleted successfully."; each skipped entry is added as a warning via `messenger()`.

## Operating notes

- The reference scan only inspects `handler_settings.target_bundles`, which is how entity-reference / entity-reference-revisions fields (the normal way paragraphs are attached) record allowed bundles. A type not listed in any field's `target_bundles` is treated as unused and deleted.
- Deleting a `paragraphs_type` removes the **type definition** (a config entity). It does not batch-delete existing paragraph content; core config-dependency handling governs any remaining content or config that referenced the type.
- No batching — all selected types are processed in a single request. Sites with a very large number of field configs incur one full `field_config` load per submit.
