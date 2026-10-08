# Hooks

Defined in `mailchimp.api.php`.

| Hook | Purpose |
|---|---|
| `hook_mailchimp_subscribe_success($list_id, $email, $merge_vars)` | React after a successful subscribe to an audience. |
| `hook_mailchimp_unsubscribe_success($list_id, $email)` | React after a successful unsubscribe. |
| `hook_mailchimp_process_webhook($type, array $data)` | Act on an incoming Mailchimp webhook (`$type` = event type). |
| `hook_mailchimp_lists_mergevars_alter(array &$mergevars, EntityInterface $entity, $entity_type)` | Alter merge vars before they are sent to Mailchimp. |
| `hook_mailchimp_lists_interest_groups_alter(array &$interests, EntityInterface $entity, array $choices)` | Alter interest groups before submission. |
| `hook_mailchimp_campaign_alter(object &$recipients, array &$template, string $campaign_id)` | Alter campaign recipients/template before save. |
| `hook_mailchimp_campaign_content_alter(array &$template, array &$content, string $campaign_id)` | Alter campaign template/content before save. |

```php
function my_module_mailchimp_lists_mergevars_alter(array &$mergevars, \Drupal\Core\Entity\EntityInterface $entity, $entity_type): void {
  $mergevars['FNAME'] = $entity->label();
}
```

The `*_mergevars_*` / `*_interest_groups_*` hooks require `mailchimp_lists`; the `*_campaign_*`
hooks require `mailchimp_campaign`.
