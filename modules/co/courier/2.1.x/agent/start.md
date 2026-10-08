# Courier — agent index

API/framework for storing and sending **multi-channel messages** to recipient **identities**. You (or
a dependent module like RNG) define channel templates, group them in a template collection, and call
`courier.manager`'s `sendMessage()`. Ships an email channel + user identity bridge, a queue, and
global default template collections. Depends on core `text` and `dynamic_entity_reference`. Config UI:
`courier.admin.settings` at `/admin/config/communication/courier`.

- **Services & entities: `CourierManager`, template collections, contexts, the `courier_email`
  entity, the queue** → [api/services.md](api/services.md)
- **The `identity_channel` plugin type: how to bridge a channel to an identity** →
  [plugins/identity-channel.md](plugins/identity-channel.md)
- **Config (`courier.settings`), admin + maintenance routes** → [configure/settings.md](configure/settings.md)
- **Permissions (`administer courier`, `courier bypass queue`)** → [permissions/permissions.md](permissions/permissions.md)

Submodules:
- `courier_system` (enabled) → [../../modules/courier_system/2.1.x/agent/start.md](../../modules/courier_system/2.1.x/agent/start.md)
- `courier_message_composer` — **not documented / not enabled**: its info declares
  `core_version_requirement: ^8.9 || ^9 || ^10`, so it is **incompatible with this Drupal 11 site**
  and cannot be installed.

Key facts:
- Central service `courier.manager` (`Drupal\courier\Service\CourierManager`):
  `sendMessage($template_collection, $identity, $options)` and `addTemplates()`.
- Plugin type `identity_channel` (manager `plugin.manager.identity_channel`,
  `Plugin/IdentityChannel/`, `@IdentityChannel` annotation, `broken` fallback). Ships
  `CourierEmail/User` (email ↔ user).
- Entities: `courier_email` (content, channel template), `courier_context` + `courier_template_collection`
  (config), `courier_message_queue_item` (content, queued messages). Also a config-entity
  `GlobalTemplateCollection`.
- Config `courier.settings`: `skip_queue` (bool), `channel_preferences` (per identity type → ordered
  channels).
- Queue `courier_message` (worker `Plugin/QueueWorker/MessageWorker`) processes queued sends on cron.
