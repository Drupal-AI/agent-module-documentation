<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclusiv Access (exclusiv_access) — agent index

Light, per-entity token gating. Version **3.0.2** (dir `3.0.x`). `core_version_requirement: ^10.1 || ^11`. Package `access`. License GPL-2.0-or-later. Depends only on core `field`.

## What it is
Attach the field type `exclusiv_access_field_type` (a boolean "activate" flag) to a fieldable content-entity bundle. Ticking it on an entity generates a random token, stored in Drupal **State** (`exclusiv_access[<entity_type>][<entity_id>]`), and prints a message with the tokenised URL. A `kernel.request` subscriber then blocks that entity's page (returns 404) for requests without the matching `?token=` value, unless the user holds `see content without token`.

## Provides
- **Field type** `exclusiv_access_field_type` — `src/Plugin/Field/FieldType/ExclusivAccessFieldType.php` (boolean column; `postSave()` mints/stores the token and messages the URL).
- **Field widget** `exclusiv_access_field_widget` — `src/Plugin/Field/FieldWidget/ExclusivAccessFieldWidget.php` (details group "Exclusiv Access Control" with an "activate" checkbox + read-only token field).
- **Field formatter** `exclusiv_access_field_formatter` — `src/Plugin/Field/FieldFormatter/ExclusivAccessFieldFormatter.php` (renders nothing).
- **Event subscriber / gate** `exclusiv_access.access_check` — `src/EventSubscriber/AccessCheck.php` (the request-time token check).
- **Permission** `see content without token` — `exclusiv_access.permissions.yml` (bypass; not an anonymous permission).
- **hook_form_alter** hooks in `exclusiv_access.module` hide cardinality/required/default-value on this field's config forms.
- No routes, no config objects/schema, no Drush, no submodules, no settings form (`configure: null`).

## Docs
- Field type / widget / formatter and the token lifecycle: [fields/field.md](fields/field.md)
- The request gate, permission, and State storage: [api/access-check.md](api/access-check.md)
