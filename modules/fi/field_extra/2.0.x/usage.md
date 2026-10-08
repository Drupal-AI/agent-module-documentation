<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field extra adds "private field" functionality: on entity types that have an owner, an author can tick a per-value **Private** checkbox on selected fields, and that field value is then hidden from everyone except the owner and privileged users.

An admin first chooses which owner-bearing entity types participate at `/admin/config/content/private-settings` (`field extra manage private field settings`). On each field's config edit form a "Allow the author to hide this field's value" checkbox (plus an optional default) is stored as a `field_extra` third-party setting. On the entity add/edit form, if the current user is the entity owner (or has `field extra access private fields` / a per-entity-type variant), each private-capable field gains a **Private** checkbox; the chosen state is persisted to the module's `field_extra_value` table via the `field_extra.manager` service (merge/delete). Enforcement is real and server-side: `hook_entity_field_access` returns `AccessResult::forbidden()` for a `view` operation when the field is marked private, the viewer is not the owner, and the viewer lacks the bypass permission. A `hook_entity_field_access` grant thus removes the value from rendered output and API responses, not just the form.

Routes are permission-gated; a listing page (`/admin/config/content/private-settings/fields`) enumerates configured private fields. Permissions can be extended per entity type through a permission callback. A Drush command surface (`FieldExtraCommands`) and a `hook_field_extra_private_alter` allow programmatic overrides.
---
Author-controlled private field values, enforced server-side via hook_entity_field_access.
---
- Let authors mark a field value as private on their own content
- Choose which owner-bearing entity types support private fields
- Enable "private" per field via the field config form
- Set a field to be private by default for new content
- Hide private field values from other authenticated users
- Grant trusted roles bypass via `field extra access private fields`
- Grant per-entity-type bypass permissions
- Enforce hiding on rendered pages (not just edit forms)
- Enforce hiding in field-access-aware API output
- List all configured private fields in the admin UI
- Add a `private-field` CSS class to private fields for theming
- Store private state in the `field_extra_value` table
- Query privacy state via the `field_extra.manager` service
- Override privacy decisions with `hook_field_extra_private_alter`
- Manage private-field settings via a dedicated permission
- Let owners always see and edit their own private values
- Use Drush commands to manage private field data
