# API — content_moderation_notifications

Two services and a token type. No plugin types, no Drush.

## Services (`content_moderation_notifications.services.yml`)

### `content_moderation_notifications.notification` → `Notification`
Sends the emails.
- `processEntity(EntityInterface $entity)` — called from `hook_entity_insert`/`update`. Skips
  syncing entities (migrations); looks up matching notifications and sends. This is the entry point.
- `sendNotification(EntityInterface $entity, array $notifications)` — builds and sends one mail per
  notification. Recipient assembly order: author (if `author` and entity is `EntityOwnerInterface`
  and owner active) → each selected role's active users that pass `view` access → ad-hoc `emails`
  (Twig-rendered, split on commas/newlines) → `user_fields` referenced users. All recipients go on
  `Bcc`; the visible recipient is the site mail unless the notification's `site_mail` (disable) flag
  is set. Subject/body/emails are rendered as inline Twig (`renderInIsolation`, with a 10.3 back-compat
  fallback), body then passed through `check_markup()` with the notification's text format.

### `content_moderation_notifications.notification_information` → `NotificationInformation`
Answers moderation questions (wraps `content_moderation.moderation_information`).
- `isModeratedEntity($entity)` — is this entity under a workflow?
- `getWorkflow($entity)` — the entity's workflow (or FALSE).
- `getPreviousState($entity)` / `getTransition($entity)` — resolve the transition being made
  (uses `$entity->last_revision`, attached in `hook_entity_presave`).
- `getNotifications($entity)` — enabled notifications whose `workflow` + `transitions` match.
- `getLatestRevision($entity_type_id, $entity_id)` — latest revision for revisionable storage.

Call from your own code:
```php
$info = \Drupal::service('content_moderation_notifications.notification_information');
if ($info->isModeratedEntity($node) && ($t = $info->getTransition($node))) {
  // $t is a workflow Transition (from-state → to-state).
}
```

## Config entity API — `ContentModerationNotificationInterface`

Load via the `content_moderation_notification` storage. Getters:
`getWorkflowId()`, `getTransitions()`, `getRoleIds()`, `getUserFields()` (returns
`{entity_type}:{field_name}` strings), `getEmails()`, `sendToAuthor()`, `disableSiteMail()`,
`getSubject()`, `getMessage()`, `getMessageFormat()`.

## Tokens (`Tokens` class + `.tokens.inc`)

Adds token type **`content_moderation_notifications`** (needs an `entity` data object). Tokens,
usable in notification subject/body:

| Token | Value |
|---|---|
| `[content_moderation_notifications:workflow]` | Label of the entity's workflow |
| `[content_moderation_notifications:from-state]` | Previous moderation state label |
| `[content_moderation_notifications:to-state]` | New/current moderation state label |

Replacements only resolve when the data entity is a moderated `ContentEntityInterface`.
Standard entity/site/user tokens (via the optional `token` module) also work in subject/body.
