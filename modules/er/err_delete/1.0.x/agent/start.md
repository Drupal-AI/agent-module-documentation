<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Recursive Delete (err_delete) — agent index

Adds a **"Recursive Delete"** operation to node edit forms. For a node that has
`entity_reference` / `entity_reference_revisions` fields, it offers a form that lists the
node's referenced entities (recursively, with circular-reference detection) and lets the
editor tick which referenced entities to delete along with the node. Depends only on core
**`node`**. Provides one permission, one config object, a settings form, and a delete form.
Version **1.0.9**. Core `^10 || ^11`. No composer requirements, no services, no plugins.

## Solution docs

- **The recursive delete mechanism** (hook, form, route, the reference-walk + delete helpers) →
  [api/recursive-delete.md](api/recursive-delete.md)
- **Settings form + config object/schema** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Hook** `err_delete_form_node_form_alter()` (`err_delete.module`): on node *edit* forms
  (`$form_id` contains `edit_form`) whose entity has at least one `entity_reference`/
  `entity_reference_revisions` **FieldConfig** field, and when the current user has permission
  `err delete entities`, it adds an `err_delete` action link to
  route `err_delete.ref_delete`. If config `replace_delete` is TRUE it first unsets the core
  `delete` action. Link label = config `replace_delete_label` (default `Recursive Delete`).
- **Route** `err_delete.ref_delete` — `/node/{node}/ref_delete`, form
  `\Drupal\err_delete\Form\ErrDeleteForm`, requirement `_permission: 'err delete entities'`,
  `node` = `entity:node` param.
- **Route** `err_delete.settings_form` — `/admin/config/err_delete/settings`, form
  `\Drupal\err_delete\Form\ErrDeleteSettingsForm`, requirement `_permission: 'err delete entities'`.
- **Form** `ErrDeleteForm` (`src/Form/ErrDeleteForm.php`): builds the reference checklist via
  the procedural helper `getFormElement()` and, on submit, calls `deleteRefEntities()` then
  deletes the node, redirecting to `/admin/content`.
- **Procedural helpers** in `err_delete.module`: `getFormElement()`, `getRecursiveFormElement()`,
  `getChildren()`, `deleteRefEntities()` — build the recursive checklist and perform the deletes.
- **Permission** `err delete entities` (`err_delete.permissions.yml`).
- **Config** object `err_delete.settings` (keys `replace_delete`, `replace_delete_label`);
  schema in `config/schema/err_delete.schema.yml`; install default in `config/install/`.
  Config translation via `err_delete.config_translation.yml`.
- **Menu/task links**: settings under *Configuration* (`system.admin_config_content`); the
  ref-delete task tab hangs off `entity.node.delete`.
- `hook_help()` for `help.page.err_delete`. No `.install`, no Drush, no services, no plugins.
