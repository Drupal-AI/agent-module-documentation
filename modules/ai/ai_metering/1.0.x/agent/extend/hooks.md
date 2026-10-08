# Hooks (ai_metering.api.php)

| Hook | Signature | Use |
|---|---|---|
| `hook_ai_metering_record_alter` | `(array &$record)` | Alter a usage record before it is written to `ai_metering_usage` (add metadata, adjust cost). |
| `hook_ai_metering_quota_exceeded` | `(int $uid, string $providerId, array $quota)` | React when a user's monthly quota is exceeded (notify, log, gate a feature). |

```php
function mymodule_ai_metering_record_alter(array &$record) {
  $record['tenant'] = mymodule_current_tenant();   // e.g. tag usage by tenant
}

function mymodule_ai_metering_quota_exceeded($uid, $providerId, array $quota) {
  \Drupal::logger('mymodule')->warning('User @u exceeded @p quota', ['@u' => $uid, '@p' => $providerId]);
}
```
Also dispatched as an event: `MeteringRecordCreatedEvent` (subscribe for post-write logic).
