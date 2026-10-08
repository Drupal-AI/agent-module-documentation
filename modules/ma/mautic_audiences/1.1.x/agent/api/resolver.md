<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audience model & API

The read path everything else consumes. Inject `@mautic_audiences.resolver`.

## `AudiencesResolverInterface` (`src/Audience/AudiencesResolverInterface.php`)
Implemented by `AudiencesResolver` and decorated by `AudiencesPreviewDecorator`. Contract: **never throws on the render path** — failures degrade to `AudiencesValue::empty()` and log to `logger.channel.mautic_audiences`.

- `resolve(): AudiencesValue` — the active visitor of the current request. Priority: authenticated user → `mtc_id` cookie (anonymous) → empty. Memoized per request. Returns `AudiencesValue::empty()` when the consent gate denies (see below).
- `resolveForUser(UserInterface $user): AudiencesValue` — background/email-first; reads `user.data`, else refreshes via the active strategy.
- `resolveForContact(string $contactId): AudiencesValue` — reads `keyvalue.expirable` (`mautic_audiences_anonymous`), else refreshes.
- `refresh(string $contactId): AudiencesValue` — forces a Mautic fetch (the only API-hitting path), persists to `user.data` (if the contact maps to a uid) or `keyvalue.expirable` with `anonymous_ttl`, and invalidates tags `mautic_audience:contact:<id>` (+ `mautic_audience:user:<uid>`).

`AudiencesResolver` is constructed from config.factory, current_user, request_stack, user.data, keyvalue.expirable, entity_type.manager, the identity plugin manager, cache_tags.invalidator, the logger, `mautic_audiences.metrics`, and the service container.

### Consent gate
`AudiencesResolver::isConsentGranted()` reads `mautic_audiences.settings:consent_callback`. Empty → allowed. Otherwise the named service is loaded from the container and called via `__invoke()` or `isAllowed()`; anything else, or any thrown exception, **fails closed** (denies) and increments `consent_denied_total`. See the `mautic_audiences_klaro` submodule for a ready implementation.

## `AudiencesValue` (`src/Audience/AudiencesValue.php`)
Immutable value object: `segments[]`, `tags[]`, `?contactId`, `updated` (int). Helpers `hasSegment()`, `hasTag()`, `isEmpty()`, `fromArray()`/`toArray()` (persistence shape), and `hash()` — a stable 16-hex SHA-256 of the sorted segments+tags (`'none'` when empty). The hash is the value of the broad `mautic_audience` cache context, so equal audiences share cache entries regardless of contact.

## Identity-strategy plugin type
Maps Drupal users ↔ Mautic contacts and performs the actual Mautic fetch. Discovered from `Plugin/MauticAudienceIdentityStrategy/` via the `#[MauticAudienceIdentityStrategy]` attribute (`src/Attribute/`); manager `plugin.manager.mautic_audiences.identity` (`IdentityStrategyPluginManager`, alter hook `mautic_audience_identity_strategy_info`).

Interface `IdentityStrategyInterface` (extends `ConfigurableInterface`, `PluginFormInterface`): `resolveContactIdForUser(UserInterface): ?string`, `resolveUserIdForContact(string): ?int`, `fetchFromMautic(string): AudiencesValue` (the only Mautic-API method; must never throw). `IdentityStrategyBase` supplies the shared services (`@advanced_mautic_integration.api`, entity_type.manager, logger) and a concrete `fetchFromMautic()` that reads the contact (tags inline) plus `GET /contacts/{id}/segments`.

Shipped plugins (`src/Plugin/MauticAudienceIdentityStrategy/`):
- `email` (`Email.php`) — maps by primary email (`getList('email:'.$email)`); reverse-maps contact→uid by `mail`.
- `custom_field` (`CustomField.php`) — reads a configurable user field holding either the Mautic contact id (`mode=contact_id`) or an alternative email (`mode=email`); default field `field_mautic_contact_id`.

Add your own by dropping a class in `src/Plugin/MauticAudienceIdentityStrategy/` with the attribute.

## Keeping data fresh
- **Webhook** — `refresh()` per event; see [endpoints/http-endpoints.md](../endpoints/http-endpoints.md).
- **Cron reconciliation** — `MauticAudiencesHooks::cron()` (`src/Hook/`) scans up to 500 `users_data` rows and enqueues up to 200 whose `updated` is older than `reconciliation_threshold` into the `mautic_audiences_user_sync` queue.
- **Queue worker** — `UserSyncQueueWorker` (`src/Plugin/QueueWorker/`, id `mautic_audiences_user_sync`, cron 60s) resolves a `['uid'=>N]` item's contact via the active strategy and calls `refresh()`.
- **Identity stitching** — `IdentityStitcher::stitch()` runs on `hook_user_login`: merges an anonymous `mtc_id` keyvalue entry into `user.data` when it maps to the same contact, else discards it.
- **Other hooks** — `hook_user_delete` drops the user's `user.data` entry.

## Drush commands (`src/Drush/Commands/AudiencesCommands.php`)
- `mautic-audiences:sync-all` (`masa`) — enqueue every active user; `--limit`, `--dry-run`.
- `mautic-audiences:sync-user <email>` (`masu`) — enqueue one user; `--inline` to run now.
- `mautic-audiences:test` (`mat`) — print a resolved audience; `--user=<email>` or `--contact-id=<n>`.

## Other services
- `mautic_audiences.segment_list` (`Service/SegmentList.php`) — caches the Mautic segment/tag inventory in `cache.default` (1h; 60s failure memo via `isAvailable()`); used by token info and the field widget. `refresh()` clears it.
- `mautic_audiences.metrics` (`Service/Metrics.php`) — coarse `state`-backed counters (see [reports/debug.md](../reports/debug.md)).
