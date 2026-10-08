# Campaign Monitor — invoked hooks

The module has no `.api.php`, but `CampaignMonitorSubscriptionManager` fires two module hooks via
`ModuleHandler::invokeAll()` after a successful remote operation:

- `hook_campaignmonitor_subscribe($list_id, $email)` — invoked after a subscribe succeeds
  (in `subscribeProcess()`).
- `hook_campaignmonitor_unsubscribe($list_id, $email)` — invoked after an unsubscribe succeeds
  (in `unsubscribeProcess()`).

Example:
```php
/**
 * Implements hook_campaignmonitor_subscribe().
 */
function mymodule_campaignmonitor_subscribe($list_id, $email) {
  \Drupal::logger('mymodule')->info('Subscribed @mail to @list', ['@mail' => $email, '@list' => $list_id]);
}
```

Related: `campaignmonitor.module` implements `hook_ENTITY_TYPE_delete()` (as `campaignmonitor_user_delete`) to
unsubscribe a deleted user's email from every list.
