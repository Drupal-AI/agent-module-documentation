<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Actions — agent index

Adds a bulk-actions control to entity-reference field **widgets** so an editor can run a core/contrib
`action` against all entities referenced by that field, from the host entity's edit form. No permissions,
no routes, no config page (`configure` null), no Drush, no plugin types. Config schema only (widget
third-party settings). Enabled per widget on *Manage form display*.

- **Turn the feature on for a field and pick which actions show (include/exclude, title)** →
  [configure/widget.md](configure/widget.md)
- **How it hooks widgets, runs actions (batch vs confirm-form sub-request), and enforces per-entity access** →
  [api/handler.md](api/handler.md)

Key facts:
- Trigger: `hook_field_widget_complete_form_alter` on any `EntityReferenceFieldItemListInterface` field.
- Third-party settings namespace `entity_reference_actions` on the widget; schema
  `field.widget.third_party.entity_reference_actions` (`enabled`, `options.action_title`,
  `options.include_exclude`, `options.selected_actions`).
- Actions offered = `action` config entities whose `type` == the field's `target_type`.
- Access enforced at run time: `$action->getPlugin()->access($entity, $currentUser)` — items without
  access are skipped (no privilege escalation).
