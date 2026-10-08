Courier is an API/framework module that stores and sends multi-channel messages to "identities" (message recipients). A dependent module defines a set of templates (one per channel, e.g. email), collects them into a template collection, replaces tokens, and hands them to Courier, which renders and queues a message per the recipient's preferred channel.

---

Courier is primarily a programmatic module — you rarely configure it directly; dependent modules
(originally [RNG](https://www.drupal.org/project/rng)) drive it. Core concepts: a **Channel** is a
template entity type implementing `ChannelInterface` (Courier ships one, the `courier_email` content
entity, with subject + text-format body); a **CourierContext** (config entity) declares which tokens
are available for replacement; a **TemplateCollection** (config entity) groups at most one template
per channel and is owned by an entity or used as a global default; an **Identity** is any entity that
is a valid recipient, bridged to a channel by an **IdentityChannel** plugin (`@IdentityChannel`
annotation with `channel` + `identity` entity-type ids; Courier ships `CourierEmail/User` linking the
email channel to Drupal users, plus a `broken` fallback). The central service `courier.manager`
(`CourierManager`) exposes `addTemplates()` and `sendMessage($template_collection, $identity, $options)`:
it renders every applicable channel template into a `courier_email`-style message, applies tokens, and
either sends immediately (when `skip_queue` is on, or the `courier bypass queue` permission is used) or
saves a `courier_message_queue_item` and enqueues a `courier_message` queue worker item. Other services
manage the message queue (`MessageQueueManager`), global template collections
(`GlobalTemplateCollectionManager`, keyvalue-backed defaults auto-imported into per-entity
collections), and plugin discovery (`IdentityChannelManager`). Config: `courier.settings`
(`skip_queue`, per-identity `channel_preferences`). Admin routes: settings and a maintenance form
under `/admin/config/communication/courier` (permission `administer courier`, restricted). Requires
core `text` and `dynamic_entity_reference` (template-collection ownership uses DER). Two submodules
ship: **courier_system** (replace core user mails with Courier templates) and **courier_message_composer**
(one-off message composer — **incompatible with Drupal 11**, not enabled here).

---

- Provide a reusable multi-channel messaging backend for a contrib/custom module.
- Send a templated email to a Drupal user through the bundled email channel.
- Define per-recipient channel preferences so a message uses the recipient's preferred channel.
- Group an email (and future SMS/other channel) template into one template collection per message type.
- Add a new delivery channel (e.g. SMS) by creating a channel entity type + IdentityChannel plugin.
- Bridge a custom "identity" entity type to a channel via an `@IdentityChannel` plugin.
- Queue outgoing messages for background cron processing instead of blocking the request.
- Bypass the queue and send in-request for time-sensitive messages (via permission or `skip_queue`).
- Replace tokens in subject/body from a declared CourierContext before sending.
- Use global default template collections auto-imported into per-entity collections.
- Store composed emails as `courier_email` entities (subject + formatted body) for later sending.
- Build the message-editing UI (per-channel template forms) into a dependent module's admin flow.
- Provide RNG-style event registration notifications.
- Fall back gracefully when a channel plugin is missing (the `broken` fallback plugin).
- Clean up orphaned template collections automatically when their owner entity is deleted.
- Inspect the queue depth via `hook_requirements` on the status report.
- Integrate the contrib Token module for a richer token picker on message forms.
- Send a message to multiple rendered channels so a fallback channel is ready if the preferred fails.
- Override Drupal's core account/user emails with Courier templates (courier_system submodule).
- Centralise all site messaging templates behind one framework rather than per-module mail hooks.
