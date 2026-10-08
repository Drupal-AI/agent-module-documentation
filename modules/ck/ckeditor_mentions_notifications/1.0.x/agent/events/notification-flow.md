<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification flow — event subscriber & mail

## Service

`ckeditor_mentions_notifications.event_subscriber` →
`EventSubscriber/NotificationMentionEventsSubscriber` (implements `EventSubscriberInterface`).
Constructor args (`.services.yml`): `@user.data`, `@plugin.manager.mail`, `@config.factory`,
`@token`, `@logger.factory` (channel `ckeditor_mentions_notifications`).

## Subscribed event

`getSubscribedEvents()` registers `CKEditorEvents::MENTION_FIRST` (`'ckeditor_mentions.mention'`,
priority 0) → `initiateNotification()`. This event is dispatched by the upstream **`ckeditor_mentions`**
module the first time a given user is mentioned in a piece of content (a separate
`MENTION_SUBSEQUENT` event exists upstream but this module does **not** subscribe to it — so only the
first mention per user per host entity notifies). The event carries `getEntity()` (host entity) and
`getMentionedEntity()` (the mentioned entity).

## `initiateNotification(CKEditorMentionsEvent $event)`

1. `$mentionedEntity = $event->getMentionedEntity();` — proceed only if it `instanceof User`.
2. Look up the mentioned user's preference: `user.data->get('ckeditor_mentions_notifications', $uid,
   'mentions_notifications_settings_key')`. **Proceed only if it === `"Enable"`.** (Default is `null`
   → no email; this is a strict opt-in.)
3. `$entity = $event->getEntity();` — proceed only if it `instanceof Node || instanceof Comment`.
4. Load `ckeditor_mentions_notification.settings`, token-replace subject and body with
   `Token::replacePlain(..., ['entity' => $entity])`.
5. `$email = $mentionedEntity->getEmail();` — recipient is always the **mentioned user's own**
   registered email. It cannot be redirected by the caller.
6. `mailManager->mail('ckeditor_mentions_notifications', 'send_ckeditor_mentions_notifications',
   $email, 'en', $params, NULL, TRUE)`. Language is hard-coded `'en'`. On `!$result['result']` it
   logs a `notice`.

## Key properties (for reasoning about behaviour)

- **Recipient is fixed** to the mentioned user's own email — no third-party redirection.
- **Strict opt-in**: no email unless the recipient set their preference to `"Enable"`.
- **First-mention only** (subscribes to `MENTION_FIRST` not `MENTION_SUBSEQUENT`).
- Only Node/Comment host entities trigger mail; other entity types are ignored.
- There is a `//TODO: Move this to a service of its own` note in source; logic lives inline in the
  subscriber.
