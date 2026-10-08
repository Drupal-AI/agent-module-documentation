# Configure — Notifications Widget settings

Everything lives in one config object: **`notifications_widget.settings`**. There is no settings
entity. Two admin forms edit it; both require core permission **`administer site configuration`**.

## The two forms

| Form | Route | Path | Form id |
|---|---|---|---|
| Notification Widget settings | `notifications_widget.notifications_widget_settings` (the `configure` route) | `/admin/config/system/notifications_widget` | `notifications_widget_settings` |
| Notifications Logger settings | `notifications_widget.notifications_widget_logger_settings` | `/admin/config/people/notifications_widget/loggers` | `notifications_widget_admin_settings` |

- **Settings form** (`NotificationsWidgetSettingsForm`): renders a details group per bundle for the
  `user` entity, every node type, every comment type, every taxonomy vocabulary, and any bundle of an
  entity type listed in `additional_entity_type`. Each group has an `enable` checkboxes group
  (Create/Update/Delete), a message textfield per action, and a redirect-link textfield per action.
  On submit it also sets `notfication_widget_conf = 1` (the "configuration saved" flag that silences
  the install nag from `hook_page_top`). Until a bundle is saved, all three actions default to enabled.
- **Logger settings form** (`NotificationsWidgetLoggerSettingsForm`): two textareas — `excluded_entities`
  and `additional_entity_type`. `validateForm()` rejects `additional_entity_type` values that name a
  built-in type (`user`, `node_type`, `comment_type`, `taxonomy_vocabulary`). Removing a type from
  `additional_entity_type` clears that type's per-bundle keys.

## Config keys

Fixed keys:

| Key | Type | Meaning |
|---|---|---|
| `excluded_entities` | CSV string | Bundles that are never logged (checked against `$entity->bundle()`). Ships a long default list of config/system bundles. |
| `additional_entity_type` | CSV string | Extra entity type ids whose bundles appear in the settings form. |
| `notfication_widget_conf` | int (0/1) | Set to 1 on first settings save; gates the admin nag message. (Machine name is misspelled in code.) |

Dynamic per-bundle keys (`{bundle}` = the bundle machine name, e.g. `article`, `user`, `page`):

| Key pattern | Type | Meaning |
|---|---|---|
| `{bundle}_enable` | CSV of `Create`,`Update`,`Delete` | Which entity ops produce a notification for this bundle. |
| `{bundle}_noti_create_message` | string | Message template used on create (token-replaced). |
| `{bundle}_noti_update_message` | string | Message template used on update. |
| `{bundle}_noti_delete_message` | string | Message template used on delete. |
| `{bundle}_redirect_create_link` | string | Link the notification points to; default `[entity:url]` (resolved to the entity canonical URL at log time). |
| `{bundle}_redirect_update_link` | string | As above, for update. |
| `{bundle}_redirect_delete_link` | string | As above, for delete. |

Message templates accept Drupal tokens; the logger only exposes `user`, and `node`/`term`/`comment`
depending on the entity type — e.g. `[user:name]`, `[node:title]`, `[comment:entity:title]`.

**Config schema note:** `config/schema/notifications_widget.schema.yml` declares only `excluded_entities`
(as `text`). The dynamic per-bundle keys and `additional_entity_type`/`notfication_widget_conf` are
unschematized — they will trip strict config-schema checks in tests.

## Set without the UI

```php
// Turn on create+update logging for the "article" node type with a custom message.
\Drupal::configFactory()->getEditable('notifications_widget.settings')
  ->set('article_enable', 'Create,Update')
  ->set('article_noti_create_message', 'New article [node:title] by [user:name]')
  ->set('article_redirect_create_link', '[entity:url]')
  ->set('notfication_widget_conf', 1)
  ->save();
```

```bash
# Exclude a bundle from logging (CSV, appended to the default list).
ddev drush config:set notifications_widget.settings excluded_entities 'block,comment_type,my_secret_type' -y
```
