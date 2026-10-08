<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Value Inheritance (EVI) shares a field value from a source entity to destination entities that reference it, and keeps them in sync.

---

You define **Inheritance** config entities at `/admin/structure/inheritance`. Each one maps a *source*
entity type / bundle / field to a *destination* entity type / bundle / field, linked through an entity
reference field on the destination that points back to the source. When entities are saved, loaded, or the
edit form is built, EVI applies the mapping so the destination reflects the source's value — how it does so
is chosen by a pluggable **field strategy** (updater plugin): `update` (keep synced), `overwrite`,
`override` (destination may locally override), `override_role_visibility` (role-aware override), and
`disable` (show the inherited value but lock the field on the destination form).

The engine is driven by entity hooks (`insert`, `update`, `presave`, `delete`, `load`, `form_alter`,
`field_group_form_process_alter`) delegating to the `entity_value_inheritance.updater` service, which uses
a `Helper` service and a set of dispatched events (`InheritancePreUpdate`, `InheritancePostUpdate`,
`InheritanceAlterField`, `InheritanceAlterUpdateList`, `InheritanceSaveEntity`) so other modules can react
or alter the update list. Configuration is admin-only (`administer inheritance` permission; the collection,
add/edit/delete forms and settings form are all gated by it).

---

- Copy a value from a source entity into referencing destination entities.
- Keep a shared field in sync whenever the source changes (update strategy).
- Let a destination locally override an inherited value (override strategy).
- Apply role-aware overrides with the override_role_visibility strategy.
- Lock and display an inherited field read-only (disable strategy).
- Overwrite the destination value unconditionally (overwrite strategy).
- Create an Inheritance mapping at /admin/structure/inheritance/add.
- Pick source entity type, bundle and field in the mapping form.
- Pick destination entity type, bundle and field.
- Choose the reference field linking destination back to source.
- Bulk-delete Inheritance configs via the list builder + delete action.
- Enable/disable an individual inheritance without deleting it.
- React to sync via Inheritance* events in a custom module.
- Alter the list of entities to update through InheritanceAlterUpdateList.
- Alter the field value applied via InheritanceAlterField.
- Add a custom field strategy by implementing an updater plugin.
- Populate a destination value on entity insert automatically.
- Clean up inheritance links when a source entity is deleted.
- Show inherited values while building destination entity edit forms.
- Integrate inherited fields with Field Group layouts.
- Configure module behaviour at /admin/structure/inheritance/settings.
- Restrict all inheritance administration behind one permission.
