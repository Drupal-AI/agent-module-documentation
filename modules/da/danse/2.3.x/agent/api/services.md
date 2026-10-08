# Services & integration APIs

## Core services (`danse.services.yml`)

| Service id | Class | Use |
|---|---|---|
| `danse.service` | `Drupal\danse\Service` | Central façade: plugin access, notification lifecycle, pause/resume. |
| `danse.query` | `Drupal\danse\Query` | Read helpers for events/notifications scoped to the current user. |
| `danse.cron` | `Drupal\danse\Cron` | Prune events/notifications/actions per config. |
| `plugin.manager.danse.plugin` | `Drupal\danse\PluginManager` | `@Danse` event-source manager. |
| `plugin.manager.danse.recipient.selection` | `Drupal\danse\RecipientSelectionManager` | `@DanseRecipientSelection` manager. |

### `danse.service` (`Service`) — key methods

- `createNotifications(): void` — for every plugin, turn unprocessed events into notifications (called
  by cron and the `dnc` Drush command).
- `getPluginInstances(): PluginInterface[]` / `getPluginInstance(string $id)` /
  `getPluginInstanceFromSubscriptionKey(string $key)`.
- `buildUserSubscriptionForm(array &$form, AccountInterface $account, bool $user_edit_mode = TRUE)` and
  `saveUserSubscriptionForm(FormStateInterface, AccountInterface)` — render/persist a user's
  subscription checkboxes (values go to `user.data` module `danse`).
- `markSeen(PayloadInterface $payload)` — mark the current user's unseen notifications for that payload
  seen.
- `checkAccess(?UserInterface, bool $ignoreConfig=FALSE)` / `checkAccessInt(int $user)` — own-user
  access checks used by the subscriptions route and the `danse_own_user` views access plugin.
- `pause()` / `resume()` / `isPaused()` — toggle the state flag `danse.event_tracking.paused`.
- `markUserNotificationsDelivered(int $uid)` / `deleteUserNotifications(int $uid)` — used from
  `hook_user_cancel`.

### `danse.query` (`Query`)

- `findEventNotificationsForCurrentUser(EventInterface): NotificationInterface[]`
- `findNotificationsForCurrentUser(PayloadInterface): NotificationInterface[]` — unseen, joined on event
  `reference`.
- `findSimilarEventNotifications(EventInterface, int $uid)` — undelivered/unseen/non-redundant matches,
  used to avoid duplicate notifications.
- `rolesAsSelectList(): array` — roles minus `anonymous`.

All current-user reads filter on `n.uid = currentUser` — there is no cross-user query surface.

## Creating events (submodule APIs)

Each event source exposes a create method on its `@Danse` plugin (get it via
`plugin.manager.danse.plugin->createInstance('<id>')`), or a wrapper service:

| Source | How to create an event |
|---|---|
| `content` | Automatic via `danse_content` entity hooks (`insert`/`update`/`delete`/`view`); `Content::processEntity()`. |
| `generic` | `\Drupal::service('danse_generic')->createDanseEvent($topicId, $label, $data)`. |
| `log` | `Log::createLogEvent($topic, $message, Payload)` (driven by `danse_log`'s logger/subscriber). |
| `form` | `Form::createFormEvent($topic, $form, $form_state)`. |
| `user` | `User::createUserEvent($topic, $account)`, `User::createChangedRolesEvents($old, $account)`. |
| `role` | `Role::createChangedPermissionsEvents($oldPermissions, $role)`. |
| `config` | `Config::processEvent($id, $data)` (driven by `danse_config`'s `ConfigSubscriber`). |
| `webhook` | `Webhook::createWebhookEvent($agent, $label, Payload)` (driven by the REST resource). |

All of these funnel into `PluginBase::createEvent($topic, $label, PayloadInterface $payload, $push=TRUE,
$force=FALSE, $silent=FALSE)`, which no-ops if `SAVED_NEW` is undefined, DANSE is paused, or the payload
fails `assertPayload()`.

## Integration hooks & extension points

- **Alter hooks:** `hook_danse_info_alter` (event-source plugin definitions),
  `hook_danse_recipient_selection_info_alter` (recipient plugin definitions).
- **`hook_danse_content_topic_operation_label_alter(string &$label, array $args, array $context)`**
  (see `modules/content/danse_content.api.php`) — customise subscribe/unsubscribe link labels.
- **ECA** (`eca_danse`): provides an ECA event plugin (id `danse`, class
  `Plugin/ECA/Event/DanseEvent` with `DanseEventDeriver`) and dispatches a `RecipientSelection`
  event (`DanseEvents::RECIPIENT_SELECTION`) so ECA models can compute recipients via the
  `eca_recipient_selection` plugin.
- **Push Framework** (optional): source plugin `danse_notification`
  (`Plugin/PushFrameworkSource/DanseNotification`) exposes undelivered+unseen notifications for push
  delivery; recipient plugins implementing `DirectPushInterface` push directly during
  `createNotifications()`.
- **Tokens:** token type `danse_notification` with a `topic` token (`danse.tokens.inc`), consumed by
  the push framework source.
- **Runtime toggle:** `Settings::get('danse_notification_delivery', TRUE)` in `settings.php` disables
  delivery/push while still recording events.

Cron entry point: `danse_cron()` → `danse.service::createNotifications()` + `danse.cron::prune()`.
