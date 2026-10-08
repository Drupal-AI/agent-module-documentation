# `@DanseRecipientSelection` plugins

The second plugin type. A recipient-selection plugin returns the list of user ids who should be
**pushed** an event regardless of whether they subscribed. They are assigned per event source on the
settings form (`recipient_selection_plugin.<pluginId>` in `danse.settings`).

- **Manager:** `plugin.manager.danse.recipient.selection` (`Drupal\danse\RecipientSelectionManager`),
  discovery dir `Plugin/DanseRecipientSelection`, alter hook `danse_recipient_selection_info`, cache tag
  `danse_recipient_selection_plugins`.
- **Annotation:** `@DanseRecipientSelection` (`Drupal\danse\Annotation\DanseRecipientSelection`).
- **Interface:** `Drupal\danse\RecipientSelectionInterface` (`label()`, `getRecipients(PayloadInterface):
  int[]`); **base:** `Drupal\danse\RecipientSelectionBase` (injects `entity_type.manager`,
  `config.factory`).

## Shipped plugins

| id | Class | Recipients |
|---|---|---|
| `role` (derived: `role:<roleId>`) | `Drupal\danse\Plugin\DanseRecipientSelection\Roles` + `RolesDeriver` | all active users having that role (`anonymous` excluded). |
| `eca_recipient_selection` (derived) | `eca_danse` `Eca` + `EcaDeriver` | computed by an ECA model reacting to the `DanseEvents::RECIPIENT_SELECTION` event. |
| (push_framework) | plugins implementing `Drupal\push_framework\…\DirectPushInterface` | pushed directly to a channel during `createNotifications()`. |

## How selection combines with subscriptions

Inside `PluginBase::createNotifications()` (only when the event's `push` flag is set):

- Each configured recipient plugin's `getRecipients($payload)` contributes uids (de-duplicated).
- Plugins implementing `DirectPushInterface` instead push immediately to their channel and record a
  `danse_notification_action` per notification (respecting `danse_notification_delivery`).
- Subscribers (from `user.data`) always get a `subscription`-trigger notification; push recipients not
  already subscribed get a `push`-trigger one.

Every recipient still passes the payload's `hasAccess($uid)` gate, so content access is enforced no
matter which plugin selected them.

## Add your own

```php
/** @DanseRecipientSelection(id = "my_recipients") */
class MyRecipients extends \Drupal\danse\RecipientSelectionBase {
  public function getRecipients(\Drupal\danse\PayloadInterface $payload): array {
    return [1, 42]; // int[] of user ids
  }
}
```

Use a deriver (like `RolesDeriver`) if you need one plugin instance per role/entity. Assign it on
`/admin/config/system/danse` under "Recipient selection plugins" (multi-select per event source), which
writes the comma-joined ids to `recipient_selection_plugin.<pluginId>`.
