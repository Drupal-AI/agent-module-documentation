# Services & the frequency entity (API)

## Subscription service — `forum_notifications_subscription.frequency`

`Drupal\forum_notifications_subscription\ForumNotificationsSubscriptionService` implements
`ForumNotificationsSubscriptionServiceInterface`. Args: `@current_user`, `@entity_type.manager`,
`@config.factory`, `@logger.channel.default`. All CRUD is on the `forum_notification_frequency`
storage. "Current user" methods use `$this->currentUser->id()`; queries do not access-check the
subscribed entity.

```php
$svc = \Drupal::service('forum_notifications_subscription.frequency');
```

| Method | Scope | What it does |
|---|---|---|
| `checkNotificationFrequencyByEntity($entity)` | current user | Loads the current user's row for `$entity->id()` (returns the entity or NULL). |
| `currentUserHasNotificationFrequencyByEntity(ContentEntityInterface $entity, string $type): bool` | current user | Count query (`accessCheck(FALSE)`) on `type` + `entity_id` + `user_id`. Drives the link's subscribe/unsubscribe state. |
| `createNotificationFrequencyByEntity($entity_id, $entity_type_id)` | current user | Creates a row for the current user: `node` ⇒ type `Forum topic` + `topic_default_frequency`; `taxonomy_term` ⇒ type `Forum` + `forum_default_frequency`. **No duplicate check.** |
| `createNotificationFrequencyForUser($entity, $user)` | given user | Auto-subscribes a poster/commenter. (Note: it reads `forum_default_frequency` for both node and term.) |
| `deleteNotificationFrequencyByEntity($entity_id)` | current user | Loads current user's row for the entity and deletes it. |
| `deleteNotificationFrequencyByEntityAll($entity_id)` | all users | Deletes every row for an `entity_id` (used on topic-node delete). |
| `deleteNotificationFrequenciesByUser($user_id)` | given user | Deletes all of a user's rows (used when a user is blocked/deactivated). |
| `deleteNotificationFrequencyByEntityAndType($entity_id, $entity_type_id)` | current user | Deletes current user's row matching `entity_id` + `user_id` + type. Unsubscribe path. |
| `getNotificationFrequencyByEntityAndType($entity_id, $entity_type_id)` | all users | All rows for an entity + type — the subscriber fan-out list used when a topic/comment is created. |
| `getUserNotificationEntities($type, $user_id = 0)` | given/current user | All of a user's rows of a type (`0` ⇒ current user). Feeds the account-form manager. |
| `getNotificationById($id)` | any | Loads a row by its own entity id (used by the account-form submit). |

Failures are caught and logged via the injected logger (channel `default`), returning NULL rather
than throwing.

## Token service — `forum_notifications_subscription.token`

`ForumNotificationsSubscriptionTokenService` (arg `@token`). Thin wrapper:
`replacePlain(string $plain, array $data): string` → core `Token::replacePlain($plain, $data)`. The
`$data` array passed in from the hooks carries `node`, `comment`, `taxonomy_term`, `frequency`,
`system_email`, `base_url`, `default_lang`, `langcode`, `date`. See [tokens.md](tokens.md) for the
token names these resolve.

## Content entity — `forum_notification_frequency`

`Entity\Frequency` (`ContentEntityType`, base table `forum_notification_frequency`, implements
`FrequencyInterface` : `ContentEntityInterface, EntityChangedInterface, EntityOwnerInterface`).
`preCreate()` defaults `user_id` to the current user.

Base fields:

| Field | Type | Notes |
|---|---|---|
| `user_id` | entity_reference → user | Owner ("Authored by"). `getOwner()/getOwnerId()`. |
| `name` | string(50) | The subscriber's account name at creation time. |
| `type` | string(50) | `Forum` or `Forum topic`. `getSubscriptionType()`. |
| `entity_id` | integer (read-only) | Id of the subscribed forum/topic. `getSubscribedEntityId()`. |
| `entity_name` | string(255) read-only | Label of the subscribed forum/topic. `getSubscribedEntityName()`. |
| `frequency` | string(50) | `Single Emails` / `Daily Digest Emails` (default `Daily Digest Emails`). `getFrequency()/setFrequency()`. |
| `status` | boolean | Published flag (default TRUE). |
| `created` / `changed` | timestamps | Created / last-changed. |
| `uuid`, `langcode` | — | Standard keys. |

### Entity handlers & admin UI

- **Routes** (auto, via `ForumNotificationFrequencyHtmlRouteProvider` extending `AdminHtmlRouteProvider`):
  collection `/admin/structure/forum_notification_frequency`, add/edit/delete/canonical under the same
  base, plus a `forum_notification_frequency.settings` form
  (`/admin/structure/forum_notification_frequency/settings`, form `FrequencySettingsForm` — a stub
  `ConfigFormBase` that saves nothing meaningful). `field_ui_base_route` enables Field UI on the
  entity.
- **List builder** `ForumNotificationFrequencyListBuilder` — columns id / name (link to edit) / type /
  entity_name / frequency.
- **Forms** `ForumNotificationFrequencyForm` (disables name/type/entity_id/entity_name, turns
  `frequency` into a two-option select) and `ForumNotificationFrequencyDeleteForm`.
- **Views data** `Entity\ForumNotificationFrequencyViewsData` (default EntityViewsData) — enables the
  shipped `your_subscription_settings` View.
- **Access handler** `ForumNotificationFrequencyAccessControlHandler`: view/update/delete/create gated
  on `view published/unpublished frequency entities`, `edit frequency entities`,
  `delete frequency entities`, `add frequency entities`; `admin_permission =
  "administer forum notification frequency entities"`. **None of these permissions are declared in a
  permissions.yml**, so the entity admin UI is effectively restricted to user 1 (who bypasses access)
  or a role granted every permission. The public subscribe/unsubscribe flow does not go through this
  handler — it manipulates storage directly.
