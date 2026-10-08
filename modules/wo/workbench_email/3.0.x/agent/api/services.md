<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: sending flow, services, hooks

You normally never call these directly — configure templates and let moderation drive them.
Reference for extending or debugging.

## End-to-end flow

1. A moderated entity is saved. `WorkbenchEmailHooks::processIfModerated()`
   (`hook_entity_insert` / `hook_entity_update`, ordered after `content_moderation`) checks
   `ModerationInformation::isModeratedEntity()`.
2. Content Moderation dispatches `content_moderation.state_changed`
   (on older core a shim in `WorkbenchEmailHooks::workbenchEmailContentModerationEventShim()`
   dispatches `ContentModerationStateChangedEvent` from the CM state entity hooks).
3. `WorkbenchTransitionEventSubscriber::onContentModerationTransition()` resolves the
   from→to transition, finds every template registered for that workflow+transition, skips
   templates whose bundle list excludes the entity, then for each resolved recipient
   (`Template::getRecipients()`) enqueues a `QueuedEmail(template, entity-uuid, to)` into queue
   `workbench_email_send:{entity_type_id}`.
4. `WorkbenchEmailProcessor::processEntity()` (service `workbench_email.processor`) claims and
   processes matching queue items in the same request (up to 30s), releasing items belonging to
   other entities. Cron is the fallback (queue worker `cron time 60`).
5. Queue worker `WorkbenchEmailProcessor` (`src/Plugin/QueueWorker/`, derived per moderated
   entity type via `WorkbenchEmailDeriver`) `processItem()`: reloads the latest revision,
   token-replaces subject/body/Reply-To against the entity (`clear => TRUE`), renders the body
   through `#type => processed_text` with the body's filter format (`renderInIsolation`), then
   calls the mail manager with module `workbench_email`, key `template::{template_id}`.
6. `WorkbenchEmailHooks::mail()` (`hook_mail`): sets the subject; if template format is `html`
   sets `Content-Type: text/html` and `params.convert = TRUE`; otherwise runs the body through
   `MailFormatHelper::htmlToText()`.

## Services

- `workbench_email.processor` (`WorkbenchEmailProcessor`, also aliased by class name) —
  `processEntity(EntityInterface $entity)`.
- `plugin.manager.recipient_type` (`RecipientTypePluginManager`) — see
  [../plugins/recipient-types.md](../plugins/recipient-types.md).
- `workbench_email.subscriber.workbench_transition` — event subscriber (internal).
- `Drupal\workbench_email\Hook\WorkbenchEmailHooks` — autowired OOP hook implementations.

## Config entity API (`TemplateInterface` / `Entity\Template`)

`getFormat()`, `getSubject()`, `getBody()` (`{value, format}`), `getReplyTo()`,
`getTransitions()`, `getBundles()`, `getRecipients(ContentEntityInterface $entity)`,
`recipientTypes($instance_id = NULL)` (returns the plugin collection or one plugin), plus the
matching setters. `QueuedEmail` is a value object: `getTemplate()`, `getUuid()`, `getTo()`.

## Hooks provided

- `hook_recipient_type_info_alter(array &$info)` — alter recipient-type plugin definitions.
