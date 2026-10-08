<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Delete Stop (entity_usage_node_delete_stop) — agent index

Addon for the contrib **Entity Usage** module. Per content type, it blocks the node
**delete confirm form** for nodes that Entity Usage reports as still used: it appends an
error to Entity Usage's delete warning and disables the delete button. A pure form-level
guard, implemented entirely in `entity_usage_node_delete_stop.module` (three form hooks) —
no routes, services, controllers, drush, or plugins.

- Requires contrib `entity_usage`. **No settings page of its own** (`configure: null`); the
  toggle lives on each content type's edit form.
- Defines **1 permission** and a **config schema** for one third-party setting.

Solutions:
- **Turn the stop on/off for a content type, and how it works at runtime** → [configure/delete_stop.md](configure/delete_stop.md)
- **Let trusted users bypass the stop** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Per-bundle switch = third-party setting `prohibit_deletion` (boolean) on `node.type.*`,
  namespace `entity_usage_node_delete_stop`. Schema key
  `node.type.*.third_party.entity_usage_node_delete_stop:prohibit_deletion`.
- **Two preconditions** gate everything: (1) `entity_usage.settings:delete_warning_message_entity_types`
  must contain `node`; (2) Entity Usage must have rendered `$form['entity_usage_delete_warning']`
  on the delete form. Otherwise the checkbox is not shown and the stop never fires.
- Permission: `skip node delete stop` (bypasses the stop).
- Hooks: `hook_form_node_type_form_alter` (adds the checkbox + the `#entity_builders`
  callback `entity_usage_node_delete_stop_entity_builder`) and
  `hook_form_node_confirm_form_alter` (applies the stop when the form is a `NodeDeleteForm`).
- Scope limit: form-only guard — there is no `hook_entity_access` / predelete, so Drush,
  Views Bulk Operations, migrations, REST/JSON:API, and `$node->delete()` still delete freely.
