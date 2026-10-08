# Hooks — content_moderation_notifications

The module invites **one** alter hook (`content_moderation_notifications.api.php`).

## `hook_content_moderation_notification_mail_data_alter(EntityInterface $entity, array &$data)`

Called from `Notification::sendNotification()` for each firing notification, just after the
module has assembled recipients and mail params but **before** the mail is sent. Use it to add or
remove recipients or tweak the message.

```php
/**
 * Implements hook_content_moderation_notification_mail_data_alter().
 */
function mymodule_content_moderation_notification_mail_data_alter(\Drupal\Core\Entity\EntityInterface $entity, array &$data) {
  // Add an extra recipient (all recipients are later forced onto the Bcc header).
  $data['to'][] = 'compliance@example.com';
}
```

`$entity` is the moderated entity being saved. Useful keys in `$data`:

| Key | Contents |
|---|---|
| `$data['to']` | Array of recipient email strings gathered so far (author, roles, ad-hoc, user-fields). Edit this to add/remove recipients. After the alter, it is filtered for empties, de-duplicated, and imploded into the `Bcc` header. |
| `$data['notification']` | The `ContentModerationNotificationInterface` config entity that fired. |
| `$data['langcode']` | Current user's preferred langcode used for the mail. |
| `$data['params']['subject']` | Rendered subject string. |
| `$data['params']['message']` | Rendered + filtered body markup. |
| `$data['params']['context']` | Token/Twig context: `entity`, `user`, and `<entity_type> => entity`. |
| `$data['params']['headers']` | Extra mail headers (the `Bcc` header is set from `to` after this alter). |

Note: mutating `$data['params']['headers']['Bcc']` here has no effect — it is (re)built from
`$data['to']` immediately after the alter runs. Change `$data['to']` instead.

## Core hooks the module implements (for context, not for you to call)

`hook_entity_presave` (attaches the previous revision), `hook_entity_insert` / `hook_entity_update`
(→ `Notification::processEntity()`), `hook_mail` (builds the `content_moderation_notification`
message, sets `From` to the site mail, applies tokens), `hook_entity_operation` (enable/disable row
ops), `hook_help`, plus `hook_token_info` / `hook_tokens` (see the api doc).
