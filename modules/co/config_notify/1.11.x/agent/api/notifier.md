# API: the notifier service

Service id: `config_notify.notifier` — class `Drupal\config_notify\NotifierService`.
Get it with `\Drupal::service('config_notify.notifier')` or inject the id. No interface is
published; call the concrete methods below.

## Public methods

| Method | Returns | Behavior |
|--------|---------|----------|
| `checkChanges()` | `bool` | `TRUE` when active config differs from (transformed) sync config. Empty sync dir → `FALSE`. |
| `getChanges()` | `string` | Newline-separated changed config **object names**. `""` when there is no drift or `list_changes` is off. Honors `list_changes_limit`. |
| `getDefaultMessage($markdown = FALSE)` | `string` | The notification body (host label + drift line + optional change list). Pass `TRUE` for the markdown/Slack variant. |
| `notifyEmail($message, $email = NULL)` | `bool` | Sends `$message` via mail key `config_notify`. `$email` empty → `system.site` mail. Returns the mail result. |
| `notifySlack($message)` | `bool` | Sends `$message` through `slack.slack_service`. Returns `FALSE` if the `slack` module is not enabled or the HTTP status is not 200. |
| `getLastNotificationSent()` | `int\|null` | Reads state `config_notify.last_sent`. |
| `setLastNotification($time)` | `void` | Writes state `config_notify.last_sent`. |

## Example: check drift and notify from code

```php
$notifier = \Drupal::service('config_notify.notifier');
if ($notifier->checkChanges()) {
  $message = $notifier->getDefaultMessage();
  $notifier->notifyEmail($message, 'ops@example.com');
  // Slack variant uses markdown formatting:
  $notifier->notifySlack($notifier->getDefaultMessage(TRUE));
  $notifier->setLastNotification(strtotime('now'));
}
```

Notes:
- `getChanges()` iterates every collection via `StorageComparer::getAllCollectionNames()` and
  `getChangelist()`, collecting the config names across create/update/delete/rename.
- Constructor dependencies (from `config_notify.services.yml`): `messenger`, `config.manager`,
  `config.import_transformer`, `config.storage.sync`, `config.storage`, `date.formatter`,
  `module_handler`, `state`, `plugin.manager.mail`, `config.factory`, `language_manager`.
