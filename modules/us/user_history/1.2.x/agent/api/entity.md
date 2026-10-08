<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `user_history` entity & lifecycle operations

## Entity

`\Drupal\user_history\Entity\UserHistory` (`ContentEntityType` id `user_history`).

- `base_table: user_history`, `translatable: FALSE`, `admin_permission: administer user_history entities`.
- entity_keys: `id` = id, `label` = label. No bundle entity — single bundle `user_history`.
- Handlers: `view_builder`, `list_builder` (`UserHistoryListBuilder`), `views_data`
  (`UserHistoryViewsData`), `access` (`UserHistoryAccessControlHandler`), forms
  (default/add/edit/delete — the add/edit/delete forms are dummies), route_provider
  `UserHistoryHtmlRouteProvider` (extends `AdminHtmlRouteProvider`, adds the settings route).
- `isPublished()` always returns `TRUE`; records are immutable (no update/delete via API).

### Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `label` | string | e.g. `12: Update - 20250714-0930` (uid + action + timestamp) |
| `created` | created | "Modified on" — when the record was written |
| `action` | string | `Insert` / `Update` / `Delete` / `Install` |
| `modified_by` | entity_reference→user | account that made the change |
| `user_deleted` | boolean | account deleted at this event? |
| `user_id` | entity_reference→user | the account this record is about |
| `user_name` | string | account name |
| `user_pass` | string | **hashed** password copy |
| `user_mail` | email | account email |
| `user_timezone` | string(32) | |
| `user_status` | boolean | Active / Blocked |
| `user_roles` | string | `; `-joined role ids |
| `user_created` / `user_changed` | created / changed | account timestamps |
| `user_access` / `user_login` | timestamp | |
| `user_init` | email | initial account email |
| `user_langcode` / `user_preferred_langcode` / `user_preferred_admin_langcode` | language | |
| `difference` | string(≤255) | human summary of what changed vs the prior record |

Getters/setters for every field are on `UserHistory` / `UserHistoryInterface` (e.g. `getUserMail()`,
`getUserRoles()`, `getModifiedBy()` returns the loaded `User`).

### Programmatic query

```php
// All history for one account, newest last.
$ids = \Drupal::entityQuery('user_history')
  ->accessCheck(FALSE)
  ->condition('user_id', $uid)
  ->sort('id')
  ->execute();
$records = \Drupal::entityTypeManager()->getStorage('user_history')->loadMultiple($ids);
```

## Lifecycle / batch operations (admin forms)

All require `administer user_history entities`. Each is a `_form` route; the heavy lifting is in the
`*.inc` files loaded by the forms.

| Route | Path | Form | Does |
|---|---|---|---|
| `user_history.batch_install_form` | `/user_history/initialise` | `UserHistoryInitialiseForm` | Seed one `Install` record per existing account (batch, `user_history.batch.inc`). Required after install — flagged by `user_history.initialise_required`. |
| `user_history.batch_update_form` | `/user_history/update` | `UserHistoryUpdateForm` | Add/remove `attached_fields` columns on the entity and back-fill values after config change. |
| `user_history.batch_archive_form` | `/user_history/archive` | `UserHistoryArchiveForm` | Export old records to a file (txt/csv/xml/json) under `private://` (or `public://`), keeping min/max per account, optionally deleting after (`user_history.archive.inc`). |
| `user_history.batch_restore_form` | `/user_history/restore` | `UserHistoryRestoreForm` | Re-import records from an archive file, skipping ones already present by label (`user_history.restore.inc`). |

## Tracking extra user fields

Set `attached_fields.<field_name> = TRUE` in `user_history.settings` (settings form), then run the
Update batch. `user_history_add_tracked_fields()` clones the user field's storage+instance onto the
`user_history` entity so the value is snapshotted alongside the base fields.

## No public service / no drush

The module exposes no tagged service API and ships no drush commands. Integration points are the
`user_history` entity itself (query/load) and Views (`views/views.md`).
