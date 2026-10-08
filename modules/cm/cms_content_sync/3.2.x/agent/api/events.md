<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: events, intents, EntityStatus, tokens

Content Sync does not ship a `*.api.php`; the intended extension point is a set of Symfony
**events** dispatched around every push/pull. Subscribe to add or strip data from the
serialized payload (this is exactly how the draggableviews and simple_sitemap submodules
work).

## Events (`src/Event/`)

| Class | `EVENT_NAME` constant | Fired |
|---|---|---|
| `BeforeEntityPush` | `cms_content_sync.entity.push.before` | before an entity is serialized & pushed |
| `AfterEntityPush` | `cms_content_sync.entity.push.after` | after push completes |
| `BeforeEntityPull` | `cms_content_sync.entity.pull.before` | before a pulled entity is saved (has `$ignore` to skip) |
| `AfterEntityPull` | `cms_content_sync.entity.pull.after` | after a pulled entity is saved |
| `BeforeEntityTypeExport` | `cms_content_sync.entity_type.push.before` | when the entity-type definition is exported to the backend (add custom properties) |

Common members: `$event->entity`, `$event->intent`; `BeforeEntityPull` also exposes
`$event->ignore`. `BeforeEntityTypeExport` exposes `getEntityTypeName()`,
`getBundleName()`, `getDefinition()` (call `addObjectProperty(...)` to attach a custom
property to the type). Register a subscriber via `event_subscriber`-tagged service.

## Intents — `PushIntent` / `PullIntent` / `SyncIntent`

`src/PushIntent.php`, `src/PullIntent.php` (both extend `SyncIntent`) are the objects passed
to handlers/events. They carry the entity, the Flow, the Pool, the action, and helpers to
read/write serialized field data (`setProperty()`, `getProperty()`, embed referenced
entities, etc.). Custom entity/field handlers receive an intent and read/write through it.

## EntityStatus (`src/Entity/EntityStatus.php`)

Per-entity, per-pool sync bookkeeping (a content entity `cms_content_sync_entity_status`).
Tracks flags such as `FLAG_IS_SOURCE_ENTITY`, `FLAG_PUSH_ENABLED`,
`FLAG_PUSHED_AS_DEPENDENCY`, `FLAG_EDIT_OVERRIDE`, `FLAG_USER_ENABLED_PUSH`, `FLAG_DELETED`,
plus last push/pull timestamps and the source URL. Read it with
`EntityStatus::getInfosForEntity($entity_type, $uuid)`. `drush cms_content_sync:check-entity-flags <uuid>`
inspects these flags.

## Services (`cms_content_sync.services.yml`)

- `cms_content_sync.field_helper` (`Helper\FieldHelper`)
- `cms_content_sync.link_handling_helper` (`Helper\LinkHandlingHelper`)
- `cms_content_sync.cli` (`Cli\CliService`) — backs the Drush commands
- `plugin.manager.cms_content_sync_entity_handler`, `plugin.manager.cms_content_sync_field_handler`

## Tokens (`cms_content_sync.tokens.inc`)

Token type `cms_content_sync` with two node-only tokens (useful for canonical URLs):
- `[cms_content_sync:source_url]` — the syndicated node's source URL (translated).
- `[cms_content_sync:source_url_untranslated]` — source URL in the default language.

Both fall back to the local canonical URL when no `EntityStatus` source URL is stored.
