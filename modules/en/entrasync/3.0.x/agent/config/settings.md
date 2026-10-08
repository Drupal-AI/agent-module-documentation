<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntraSync configuration entity, form, routes, permission

Source: `src/Entity/SyncEntity.php`, `src/Form/SyncEntityForm.php`,
`src/Form/SyncEntityDeleteForm.php`, `src/Form/SyncEntityPerformSyncForm.php`,
`src/Entity/ListBuilder/SyncEntityListBuilder.php`, `entrasync.routing.yml`,
`entrasync.permissions.yml`, `config/schema/entrasync.schema.yml`.

## Install / enable

`drush en entrasync` pulls in `key` and `ms_graph_api`. Enable at least one storage submodule
(`entrasync_user` and/or `entrasync_node`) — with none enabled the storage-plugin radios are empty.
Update hook `entrasync_update_10302` enables `entrasync_user` if missing. First set up a Graph key
in the Microsoft Graph API module (Key entity of type `ms_graph_api`), then create syncs.

## Config entity `entrasync` (`SyncEntity`)

`ConfigEntityBase`, `config_prefix = "entrasync.entity"`, `admin_permission =
"administer entra sync settings"`, entity keys `id` + `label`. Exported/config keys (schema
`entrasync.entrasync.entity.*`):

- `id`, `label` — machine id + label.
- `graph_key` (string) — **id of a Key entity** (type `ms_graph_api`) used to build the Graph client.
  Stores only the key reference, never a secret.
- `graph_properties` (sequence of string) — Entra user properties to fetch (from
  `EntraSync::getAllEntraProperties()`; `mail` is always fetched and its checkbox is disabled).
- `filter` (bool) + `entrafilter_property` / `entrafilter_operator` / `entrafilter_value` — optional
  post-fetch reduction (operators: startswith, endswith, contains, notcontains, equals, notequals,
  empty, notempty).
- `retrieve_on_cron` (bool) — run this sync on `hook_cron`.
- `delta_query` (bool) — use a stored Graph delta link so only new/changed users are fetched.
- `storage_plugin` (string) — which `EntraSyncStorage` plugin to use (`user`/`node`); locked after
  first save.
- `send_mail_on_activate` (bool) — user plugin only; send the admin-created welcome mail.
- `modify_entrauser_roles` (sequence) — user plugin only; roles added to imported accounts.
- `generic_entity_label_mapping` (string) — Entra property used for username/title.
- `generic_entity_status` (int) — default active/blocked (user) or published/unpublished (node).
- `generic_field_mapping` (sequence) — Drupal field → Entra property map.
- `generic_bundle` (string) — target bundle; locked after first save.
- `generic_entity_create_revision` (bool) — node plugin; new revision when synced data changes.

`SyncEntity::preDelete()` calls the service to remove managed-entity rows and the delta state for
the deleted sync.

## Admin form (`SyncEntityForm`)

Add/edit form. Sections: **Graph API settings** (`graph_key` via `#type => 'key_select'` filtered to
`['type' => 'ms_graph_api']`, and `graph_properties` checkboxes), **General settings** (filter
controls, `retrieve_on_cron`, `delta_query`, `storage_plugin` radios), a bundle selector, and a
plugin-supplied sub-form. Storage-plugin selection and bundle drive AJAX rebuilds
(`ajaxUpdateBundleSelector`, `ajaxUpdateFieldsForSelectedBundle`). `validateForm()`/`submitForm()`
delegate to the active storage plugin (`EntraSync::loadStoragePlugin()`), then save and redirect to
`entrasync.collection`. The list builder (`SyncEntityListBuilder`) shows key label + property/filter/
mapping/schedule summaries and adds a **Perform Sync** operation.

## Routes (`entrasync.routing.yml`) and permission

All five routes require `_permission: 'administer entra sync settings'`:

- `entrasync.collection` — `/admin/config/services/entrasync` (entity list; `configure` route).
- `entity.entrasync.add_form` — `/admin/config/services/entrasync/add`.
- `entity.entrasync.edit_form` — `/admin/config/services/entrasync/{entrasync}/edit`.
- `entity.entrasync.delete_form` — `.../{entrasync}/delete` (`SyncEntityDeleteForm`, confirm form).
- `entity.entrasync.sync` — `.../{entrasync}/sync` (`SyncEntityPerformSyncForm`, confirm form that
  calls `EntraSync::fullSync()`).

Permission `administer entra sync settings` (`entrasync.permissions.yml`) has `restrict access: true`
and a description noting it can alter user roles and statuses, so it is given only to trusted roles.
Menu link `entrasync.admin_settings` (under Configuration → Web Services); action link
`entrasync.add_action` on the collection page.
