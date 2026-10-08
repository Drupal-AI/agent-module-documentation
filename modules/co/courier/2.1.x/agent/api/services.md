# Courier — services, entities & the send flow

## Services (`courier.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `courier.manager` | `Service\CourierManager` | Add templates to a collection; render + send/queue a message. |
| `courier.manager.message_queue` | `Service\MessageQueueManager` | Send a `courier_message_queue_item`'s messages (used by the queue worker and skip-queue path). |
| `courier.manager.global_template_collection` | `Service\GlobalTemplateCollectionManager` | Keyvalue-backed global default collections; import into per-entity collections; notify on channel change. |
| `plugin.manager.identity_channel` | `Service\IdentityChannelManager` | Discover/instantiate `identity_channel` plugins (see plugins doc). |
| `courier.paramconverter.channel` | `ParamConverter\CourierChannelConverter` | Route param converter for `{courier_channel}`. |

## Core entities

- **`courier_email`** (content entity, `Entity\Email`, implements `EmailInterface`/`ChannelInterface`,
  `admin_permission = "administer courier_email"`). Fields: `mail`, `name`, `subject`, `body`
  (text_long with format), `langcode`. `applyTokens()` runs `\Drupal::token()->replace()` on subject +
  body; `sendMessages()` builds `"Name <email>"` and sends via core `plugin.manager.mail`
  (`system`/`courier_email` key), honouring an optional `reply_to` option. `isEmpty()` = missing body
  or subject. `import/exportTemplate()` map to `{subject, body}`.
- **`courier_context`** (config, `courier.context.*`) — declares the token types available for a
  message (`tokens` sequence).
- **`courier_template_collection`** (config, `courier.template_collection.*`) — up to one template per
  channel, plus `contexts` and an optional owner.
- **`GlobalTemplateCollection`** (config entity) — a named default collection (e.g.
  `courier_system.user_password_reset`) imported into per-entity collections on load.
- **`courier_message_queue_item`** (content) — a saved batch of rendered channel messages awaiting
  delivery; queue depth is reported via `hook_requirements`.

## Send flow — `CourierManager::sendMessage($template_collection, $identity, $options = [])`

1. `validateTokenValues()` on the collection.
2. Create a `MessageQueueItem` with the identity + options.
3. For each channel valid for the identity (`identityChannelManager->getChannelsForIdentity()`) that has
   a template, get the `identity_channel` plugin and `applyIdentity()` it onto a duplicated template
   (skips on `IdentityException`, skips empty messages).
4. Copy the collection's token values/options onto the message, set the `identity` token, `applyTokens()`,
   save the message, add it to the queue item.
5. If any messages were produced: when `getSkipQueue()` (config `skip_queue`) is true, send immediately
   via `MessageQueueManager::sendMessage()`; otherwise save the queue item and enqueue a
   `courier_message` queue item (processed on cron by `Plugin/QueueWorker/MessageWorker`).
   Returns the `MessageQueueItem`, or `FALSE` if nothing could be sent.

`addTemplates(&$template_collection)` fills the collection with an empty template for every channel
type known to the identity channel manager that isn't already present.

## Minimal programmatic use

```php
$manager = \Drupal::service('courier.manager');
/** @var \Drupal\courier\Entity\TemplateCollection $tc */
$tc->setTokenValue('user', $account);        // token values for the CourierContext
$manager->sendMessage($tc, $account);        // queues (or sends) per the user's channel preference
```

## Hooks / entity reactions (`courier.module`)

- `hook_entity_insert/update` on a `ChannelInterface` entity notifies the global-collection manager of
  template changes; `hook_entity_load` imports from the global collection.
- `hook_entity_predelete` removes a deleted channel from its collection and deletes template
  collections owned by a deleted entity.
- The IdentityChannel plugin manager exposes `hook_courier_identity_channel_info` alter.
