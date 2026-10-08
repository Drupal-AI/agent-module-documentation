<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Copy with Reference (entity_copy_reference) — agent index

Adds a configurable **one-click "Copy"** action to selected node types. Copying a node runs
`createDuplicate()`, applies a per-type title prefix/suffix, marks the copy unpublished, sets the
current user as author, and treats each entity-reference field per config: **keep**, **clone**
(recursively duplicate the target), or **clear**. Package **Node**. Nodes only. Version **1.0.3**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.

- Dependencies (info.yml): core `node`, `field`, `system (>= 9.0)`. No composer.json, no external
  libraries, no submodules, no Drush, no plugin types. Ships a CSS-only library
  `entity_copy_reference/entity-copy-reference-form` (`css/form.css`).
- **Two forms, two routes, two permissions** — the admin config wizard and the per-node copy flow →
  [copy/mechanism.md](copy/mechanism.md)
- **Config form, the `entity_copy_reference.settings` object, and reference-field options** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- Routes (`entity_copy_reference.routing.yml`):
  - `entity_copy_reference.form` — `/admin/config/development/entity-copy-reference/config`,
    perm `administer entity_copy_reference` (config wizard).
  - `entity_copy_reference.copy` — `/node/{node}/copy`, perm `use entity_copy_reference`
    (confirmation form that creates the copy).
- Permissions (`entity_copy_reference.permissions.yml`): `administer entity_copy_reference`
  (restrict access), `use entity_copy_reference`.
- Service class `Drupal\entity_copy_reference\EntityCopyReference` (`src/EntityCopyReference.php`) —
  `getConfig()`, `isCopyEnabled(Node, $user = NULL)`, `copyEntity($node, $is_referenced_entity)`.
  Not a registered service; instantiated with `new` in the module file and confirm form.
- Forms: `EntityCopyReferenceConfigForm` (two-step wizard), `EntityCopyReferenceConfirm`
  (per-node confirm), both in `src/Form/`.
- Hooks (`entity_copy_reference.module`): `hook_help`, `hook_menu_local_tasks_alter`
  (adds the "Copy" tab on `entity.node.edit_form`/`entity.node.canonical`),
  `hook_entity_operation_alter` (adds the "Copy" operation to node rows).
- Config object: `entity_copy_reference.settings` (key `content_types`). No config schema ships,
  no `config/install` default.
