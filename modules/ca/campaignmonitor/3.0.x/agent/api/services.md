# Campaign Monitor — services & programmatic subscribe

Two services (see `campaignmonitor.services.yml`). `CampaignMonitorSubscriptionManager` **extends**
`CampaignMonitorManager`, so it also exposes the manager's list/subscriber methods.

## `campaignmonitor.manager` — `CampaignMonitorManager`
Wraps the createsend-php SDK. The SDK objects target Campaign Monitor's fixed API host (no arbitrary URL).

Selected methods:
- `getLists()` — all lists (cached); `getExtendedList($list_id)` — list incl. CustomFields.
- `isListEnabled($list_id)` / list enablement is stored in config.
- `getListSettings($list_id)` / `setListSettings($list_id, $values)` — per-list display + custom-field config.
- `isSubscribed($list_id, $email)`, `getSubscriber($list_id, $email)`, `getUserSubscriptions($email)`.
- `subscribe($list_id, $email, $name, array $customFields)` / `unsubscribe($list_id, $email)` — raw SDK calls.
- `createClientObj()` → `\CS_REST_Clients` (or NULL if no Client ID); `removeSubscriberFromCache()`.

## `campaignmonitor.subscription_manager` — `CampaignMonitorSubscriptionManager`
Higher-level subscribe/unsubscribe with queueing, messaging and form building.

- `userSubscribe($list_id, $email, $name, $merge_vars = [], $interests = [], $double_optin = FALSE, $format = 'html')`
  — subscribes immediately, or queues to `campaignmonitor_queue_cron` when config `cron` is on.
- `userUnsubscribe($list_id, $email, $delete = FALSE, $goodbye = FALSE, $notify = FALSE)`.
- `singleSubscribeForm($config, $email = '')` — builds the per-list Form API elements (name + custom fields).
- `subscribeSettingsForm($config)` — the block/registration settings form (list type, list id, text).
- `subscribeSubmitHandler(&$form, FormStateInterface $form_state)` — shared submit; reads serialized `config`,
  `Html::escape()`s the email/name, loops selected lists and calls `userSubscribe()`.

Example (subscribe an email from code):
```php
$sm = \Drupal::service('campaignmonitor.subscription_manager');
$sm->userSubscribe($list_id, 'visitor@example.com', 'Visitor Name', ['CustomField1' => 'x']);
```

## Subscribe block & form
- Block plugin `campaignmonitor_subscribe_block` (`CampaignMonitorSubscribeBlock`, category "Campaign Monitor
  Signup"). Its config form (`subscribeSettingsForm`) picks single-list vs user-select and the target list(s).
- `build()` renders `CampaignMonitorSubscribeForm` (`campaignmonitor_subscribe_form`), which shows an email
  field (defaulted to the logged-in user's mail) plus the per-list fields, and submits via the subscription
  manager. Access to the form is whatever gates the block placement — it is meant to be visitor-facing.
- The selectable lists are constrained to the admin-enabled lists, so a submitter cannot target an arbitrary list.

## Queue
`queue.campaignmonitor_queue_cron` is a `DatabaseQueue` (`campaignmonitor_queue_cron`). Queued items carry a
`function` name + `args`; processed on cron up to `batch_limit`.
