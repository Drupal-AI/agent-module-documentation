# Courier — the `identity_channel` plugin type

An **IdentityChannel** plugin bridges a *channel* (a template entity type implementing
`ChannelInterface`) to an *identity* (a recipient entity type): it knows how to stamp a specific
recipient's address onto a rendered message of that channel.

- Manager: `plugin.manager.identity_channel` → `Service\IdentityChannelManager` (extends
  `DefaultPluginManager`, implements `FallbackPluginManagerInterface`).
- Discovery: class files in `src/Plugin/IdentityChannel/`, annotation
  `Drupal\courier\Annotation\IdentityChannel`, interface `IdentityChannelPluginInterface`.
- Alter hook: `hook_courier_identity_channel_info`. Cache bin key `courier_identity_channel_info_plugins`.
- Fallback: `getFallbackPluginId()` returns `broken` (`Plugin/IdentityChannel/Broken.php`).

## Annotation fields (`@IdentityChannel`)

```php
/**
 * @IdentityChannel(
 *   id = "identity_courier_email_user",
 *   label = @Translation("Email to user"),
 *   channel = "courier_email",   // entity type id implementing ChannelInterface
 *   identity = "user",           // entity type id of the recipient
 *   weight = 0
 * )
 */
```

## Interface contract

Implement `IdentityChannelPluginInterface`. The key method used by the send flow is:

- `applyIdentity(ChannelInterface &$message, EntityInterface $identity)` — set the recipient's
  address/details on the message (throw `Drupal\courier\Exception\IdentityException` if the identity
  can't be applied, e.g. no email). Courier ships `CourierEmail/User` which copies the user's email +
  name onto a `courier_email` message.

## Manager lookups (from `CourierManager`, or call directly)

- `getChannels()` — `[channel => [identity types...]]` for all non-fallback plugins.
- `getIdentityTypes()` — distinct identity entity-type ids.
- `getCourierIdentityPluginID($channel_type, $identity_type)` / `getCourierIdentity(...)` — resolve
  the plugin (or its instance) for a channel+identity pair.
- `getChannelsForIdentity($identity)` (interface method) — channels available for a given identity.

## Adding a new channel (e.g. SMS)

1. Create a channel entity type implementing `ChannelInterface` (model it on `Entity\Email`:
   subject/body-equivalent fields, `applyTokens()`, `sendMessages()`, `import/exportTemplate()`,
   `isEmpty()`).
2. Create an `@IdentityChannel` plugin whose `channel` is your new type and `identity` is the recipient
   entity type, implementing `applyIdentity()`.
3. Optionally add the channel to `courier.settings` `channel_preferences` so it participates in
   per-identity preference ordering.
