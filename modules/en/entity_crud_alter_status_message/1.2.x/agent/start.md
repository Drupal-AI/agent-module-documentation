<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity CRUD Alter Status Message (entity_crud_alter_status_message) — agent index

Replaces Drupal's default "created / updated / deleted" **status message** shown after saving or
deleting an entity with admin-configured, token-aware text. Supports **node**, **taxonomy_term**
and **media** only. Package `Other`. Depends on **`token`**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.2.1 (version-dir 1.2.x).

- **Config entity, admin listing/forms, routes & permission** →
  [config/settings.md](config/settings.md)
- **How the message override actually happens (the hook + submit callback + manager)** →
  [api/message-override.md](api/message-override.md)

## What it actually is

- One **config entity type** `entity_crud_alter_status_message`
  (`src/Entity/EntityCrudAlterStatusMessage.php`, `ConfigEntityBase`). Each entity = a rule keyed
  `{entity_type}.{entity_bundle}.{crud_action}` with a `message`. `config_export`: `id`,
  `entity_type`, `entity_bundle`, `crud_action`, `message`. Getter `getMessage()` returns
  `message['value']`.
- One **service** `entity_crud_alter_status_message.manager`
  (`EntityCrudAlterStatusMessageManager`, arg `@entity_type.manager`) — resolves valid entity
  types, the action mapping, and the configured message for a given type/bundle/operation.
- One **permission** `administer entity_crud_alter_status_message`
  (`*.permissions.yml`) — gates every route and is the entity `admin_permission`.
- One **hook** `hook_form_alter()` + submit callback in `entity_crud_alter_status_message.module` —
  the runtime that swaps the status message.
- **No** plugins, no Drush, no blocks, no `.install`, no config/install defaults. Provides a
  config schema (`config/schema/`, `message` typed `text_format`).

## Routes (from `entity_crud_alter_status_message.routing.yml`)

All require `_permission: 'administer entity_crud_alter_status_message'`:

- `entity.entity_crud_alter_status_message.collection` — `/admin/config/system/entity-crud-alter-status-message` (list builder; this is the `configure` route).
- `.add_form` — `/admin/config/system/entity_crud_alter_status_message/add`.
- `.edit_form` — `/admin/config/system/entity-crud-alter-status-message/{entity_crud_alter_status_message}`.
- `.delete_form` — `.../{…}/delete`.

(The entity annotation's `links` list `/admin/structure/...` paths, but `routing.yml` overrides
those route names to the `/admin/config/system/...` paths above.) A local action + a menu link
under *Configuration → System* point at the collection.
