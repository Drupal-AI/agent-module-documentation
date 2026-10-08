<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entity, forms, routes & permission

## Install / enable

`composer require drupal/entity_crud_alter_status_message` then enable
`entity_crud_alter_status_message` (pulls in the required `token` module). No `.install`, no
`config/install` defaults — the module ships nothing until you create rules.

## The config entity

`src/Entity/EntityCrudAlterStatusMessage.php` — `@ConfigEntityType` id
`entity_crud_alter_status_message`, `config_prefix` `entity_crud_alter_status_message`,
`admin_permission` `administer entity_crud_alter_status_message`. `entity_keys` = `{id}`.
`config_export` (and stored config keys): `id`, `entity_type`, `entity_bundle`, `crud_action`,
`message`. `getMessage()` returns `$this->message['value'] ?? ''`.

Config object name pattern: `entity_crud_alter_status_message.entity_crud_alter_status_message.{id}`
where `id` = `{entity_type}.{entity_bundle}.{crud_action}` (built in the form's `validateForm()`
via `implode('.', array_filter([...])) ?: '_'`).

Schema `config/schema/entity_crud_alter_status_message.schema.yml` (`type: config_entity`):
`id` (string), `entity_type` (string), `entity_bundle` (string), `crud_action` (string),
`message` (**`text_format`**).

## Handlers (from the annotation)

- `list_builder` → `EntityCrudAlterStatusMessageListBuilder` — table columns id / entity_type /
  entity_bundle / crud_action (mapped to Create/Update/Delete via the manager) / message.
- `form.add` and `form.edit` → `Form\EntityCrudAlterStatusMessageForm`.
- `form.delete` → core `Drupal\Core\Entity\EntityDeleteForm`.

## Routes & permission

`entity_crud_alter_status_message.routing.yml` — every route requires
`_permission: 'administer entity_crud_alter_status_message'`:

| Route name | Path | Provider |
|---|---|---|
| `entity.entity_crud_alter_status_message.collection` | `/admin/config/system/entity-crud-alter-status-message` | `_entity_list` |
| `entity.entity_crud_alter_status_message.add_form` | `/admin/config/system/entity_crud_alter_status_message/add` | `_entity_form: …add` |
| `entity.entity_crud_alter_status_message.edit_form` | `/admin/config/system/entity-crud-alter-status-message/{entity_crud_alter_status_message}` | `_entity_form: …edit` |
| `entity.entity_crud_alter_status_message.delete_form` | `.../{…}/delete` | `_entity_form: …delete` |

The single permission is declared in `entity_crud_alter_status_message.permissions.yml`
(*Administer entity crud alter status message*). `configure` in `.info.yml` points at the
collection route. `.links.action.yml` adds an "Add alter status message" action on the collection;
`.links.menu.yml` adds a *Configuration → System* menu link to the collection.

## The add/edit form (`Form\EntityCrudAlterStatusMessageForm`, extends `EntityForm`)

DI (`create()`): `entity_type.manager`, `messenger`, `entity_type.bundle.info`,
`entity_crud_alter_status_message.manager`, `token`. Fields built in `form()`:

- `entity_type` — `select`, options from `manager->getValidEntityTypes()`
  (**node / taxonomy_term / media**, only those present). AJAX-refreshes the wrapper.
- `entity_bundle` — `select`, options from `entity_type.bundle.info` for the chosen type.
- `crud_action` — `select`, options from `manager->getCrudMapping($entity_type)` (see
  [../api/message-override.md](../api/message-override.md) for the mapping).
- `message` — **`text_format`** (required); `#description` notes tokens are allowed.
- `token_help` — a `token_tree_link` browser for the selected entity type (shown once a type is
  chosen).

`entityTypeAjaxUpdate()` rebuilds the bundle and action option lists when the entity type changes.
`validateForm()` computes the `id`, and if another rule with that id already exists it sets an
error with an "Edit it" link (prevents duplicate type/bundle/action rules). `save()` writes the
entity, adds a "created/updated" message, and redirects to the collection.
