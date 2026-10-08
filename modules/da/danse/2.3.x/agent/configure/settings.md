# Configure DANSE settings

Form `Drupal\danse\Form\Settings` (`getFormId()` = `danse_settings`) at route **`danse.settings`** →
`/admin/config/system/danse`, permission `administer site configuration`. Editable config:
**`danse.settings`**. A confirm form `Drupal\danse\Form\Prune` (route `danse.prune`,
`/admin/config/system/danse/prune`, same permission, action link on the settings page) runs pruning on
demand.

## Config keys (`danse.settings`)

| Key | Type | Meaning |
|---|---|---|
| `subscriptions_as_tab.events` | bool | Show event-subscription checkboxes as a profile tab (`1`) vs. inside the user edit form (`0`). |
| `subscriptions_as_tab.view` | bool | Show active-subscriptions view as a profile tab vs. in the edit form. |
| `subscriptions_as_tab.expand` | bool | Start the subscriptions list expanded. |
| `recipient_selection_plugin.<pluginId>` | string | Comma-separated `@DanseRecipientSelection` plugin ids used to push events of the given `@Danse` plugin, regardless of subscription. Read via `explode(',', …)`. |
| `prune.<pluginId>.type` | string | One of `all` (keep forever), `records`, `days`, `weeks`, `months`, `years`. |
| `prune.<pluginId>.value` | int | Count of records / time units to keep (ignored when type is `all`). |

`<pluginId>` is a `@Danse` event-source id (`content`, `config`, `log`, `user`, `role`, `form`,
`generic`, `webhook`). The form iterates `danse.service::getPluginInstances()`, so a row appears per
enabled source.

Install defaults (`config/install/danse.settings.yml`):

```yaml
subscriptions_as_tab:
  events: 1
  view: 1
  expand: 0
recipient_selection_plugin:
  config: default
  content: admins
  log: admins
prune: {  }
```

## Set via drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('danse.settings');
$config->set('subscriptions_as_tab.events', TRUE);
// Push all content events to the "role:administrator" recipient plugin:
$config->set('recipient_selection_plugin.content', 'role:administrator');
// Keep only the last 1000 log events:
$config->set('prune.log.type', 'records')->set('prune.log.value', 1000);
$config->save();
```

```bash
drush config:set danse.settings prune.content.type days -y
drush config:set danse.settings prune.content.value 90 -y
```

## What happens at runtime

- On `hook_cron` (`danse_cron`): `danse.service::createNotifications()` turns unprocessed events into
  notifications, then `danse.cron::prune()` deletes events/notifications/actions per `prune.*` (uses
  `accessCheck(FALSE)` entity queries; `type: records` keeps the newest N by id, time types keep rows
  newer than `strtotime('now -value type')`).
- The **Prune** form (`danse.prune`) runs the same `Cron::prune()` but through a Batch (`danse_batch_prune`).
- Global kill switch: `\Drupal\Core\Site\Settings::get('danse_notification_delivery', TRUE)` in
  `settings.php`. When `FALSE`, new notifications are created already marked delivered and push channels
  are skipped (events are still recorded).
- Event tracking can be paused (state key `danse.event_tracking.paused`) via the Drush commands or
  `danse.service::pause()/resume()`; while paused, `PluginBase::createEvent()` returns early and no
  events are recorded.

## Config schema

The base `danse` module ships **no** `config/schema/` file for `danse.settings` (there is no typed
schema for these keys). The only schema in the project is `eca_danse`'s
`config/schema/eca_danse.schema.yml`. The `config_devel` block in `danse.info.yml` tracks
`danse.settings` plus the optional views/block config that ships the reporting and user-notification UI:
`views.view.danse_events`, `views.view.danse_notifications`, `views.view.danse_user_notifications`,
`views.view.danse_notification_actions`, and
`block.block.views_block__danse_user_notifications_block_1`.
