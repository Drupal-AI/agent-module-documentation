# `@Danse` event-source plugins

The primary plugin type. An event source defines the events it recognises, listens for them and calls
DANSE core to record `danse_event` entities, declares which subscriptions users may pick, and renders
the redirect for notifications.

- **Manager:** `plugin.manager.danse.plugin` (`Drupal\danse\PluginManager`), discovery dir
  `Plugin/Danse`, alter hook `danse_info`, cache tag `danse_plugins`.
- **Annotation:** `@Danse` (`Drupal\danse\Annotation\Danse`) — `id`, `title`/`label`, `description`.
- **Interface:** `Drupal\danse\PluginInterface`; **base:** `Drupal\danse\PluginBase`.

## Shipped plugins

| id | Class (submodule) | Recognises |
|---|---|---|
| `content` | `danse_content` `Content` | create/update/delete/publish/unpublish of any content entity + comment threads |
| `config` | `danse_config` `Config` | config entity `save` |
| `log` | `danse_log` `Log` | log/watchdog entries |
| `user` | `danse_user` `User` | user create/update/delete + role add/remove |
| `role` | `danse_user` `Role` | role permission add/remove |
| `form` | `danse_form` `Form` | form `submit` |
| `generic` | `danse_generic` `Generic` | arbitrary events raised in code |
| `webhook` | `danse_webhook` `Webhook` | events POSTed to the REST endpoint |

## Add your own

1. Create `Plugin/Danse/MySource.php` extending `PluginBase` with an `@Danse(id="mysource", …)`
   annotation.
2. Implement `assertPayload(PayloadInterface): bool` (type-check your payload).
3. Provide a **Payload** class extending `Drupal\danse\PayloadBase` implementing `PayloadInterface`:
   `getEventReference()` (unique string), `getSubscriptionReferences(EventInterface)` (subscription keys
   this event should notify), `label(EventInterface)`, `prepareArray()` / `createFromArray()` (JSON
   round-trip), `getEntity()`, and **`hasAccess(int $uid): bool`** (return whether that user may see the
   subject — gate content access here).
4. From your listener (an entity hook, event subscriber, etc.) call the protected
   `PluginBase::createEvent($topic, $label, $payload, $push=TRUE, $force=FALSE, $silent=FALSE)`.
5. Optional overrides: `getSupportedSubscriptions(array $roles)` (return `key => title` checkboxes for
   the user profile — key must come from `$this->subscriptionKey(...)`), `assertSubscriptionKey()`
   (validate a key belongs to the current user's roles/entity; used by the content AJAX access check),
   `buildForm()` (add rows to the settings form), `getRedirectUrl(EventInterface)` (where a notification
   click lands).

### What core does for you

`PluginBase::createNotifications()` loads unprocessed events for the plugin, resolves subscribers
(`getSubscribers()` reads `user.data` for each of the payload's subscription references, keeping only
active users) and push recipients (from the configured `@DanseRecipientSelection` plugins when the event
is `push`), then creates one `danse_notification` per recipient via `createNotification()` — which
enforces `hasAccess()` and de-duplicates. Recipients are never notified twice for one event.

Skeleton:

```php
/** @Danse(id = "mysource", label = @Translation("My source")) */
class MySource extends \Drupal\danse\PluginBase {
  public function assertPayload(\Drupal\danse\PayloadInterface $payload): bool {
    return $payload instanceof MyPayload;
  }
  public function raise(MyPayload $payload): void {
    $this->createEvent('changed', $payload->label($event ?? NULL), $payload);
  }
}
```
