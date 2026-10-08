<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub (activitypub) — agent index

Drupal-11 server implementation of the W3C **ActivityPub** federation protocol (Fediverse:
Mastodon, Pixelfed, Pleroma, GoToSocial…). Provides actors, inbox/outbox, followers/following,
HTTP-Signature signing, WebFinger discovery and NodeInfo stats.

## Dependencies
- Drupal modules: `image`, `options`, `webfinger` (drupal/webfinger ~2.0), `nodeinfo` (~1.0).
- Composer libs: `swentel/activitypub` (ActivityPhp server), `micilini/video-stream`,
  `drupal/simple_oauth` (used by the API submodules). PHP `>=8.3`.
- Suggested: `drupal/reader`, `drupal/scheduler`, `drupal/imagecache_external`, `drupal/restui`.

## Content entities
- `activitypub_actor` (`src/Entity/Actor.php`) — a Person/Instance actor owned by a user; name, keys.
- `activitypub_activity` (`src/Entity/Activity.php`) — a stored inbox/outbox ActivityStreams activity
  (type, actor, object, payload, `status`=published, `visibility`, `collection`).
- `activitypub_timeline_item` (`src/Entity/TimelineItem.php`) — per-user timeline pointer to an activity.

## Config entity + plugin type
- `activitypub_type` config entity (`src/Entity/Type.php`) maps content to ActivityStreams objects.
- `@ActivityPubType` plugin type (`src/Annotation/ActivityPubType.php`,
  manager `src/Services/Type/TypePluginManager.php`, base `TypePluginBase`). Core plugins:
  `activitypub_core` (Core.php), `activitypub_static_types` (StaticTypes.php — Follow/Accept/Undo/Delete),
  `activitypub_dynamic_types` (DynamicTypes.php — entity→object), `activitypub_context` (Context.php).

## Key services (`activitypub.services.yml`)
- `activitypub.signature` (`Services/Signature.php`) — RSA key gen/storage + HTTP-Signature sign/verify.
- `activitypub.utility` (`Services/Utility.php`) — server factory, payload→activity, URL/entity resolution.
- `activitypub.process.client` (`Services/ProcessClient.php`) — inbox/outbox queue workers + delivery.
- `activitypub.outbox`, `activitypub.timeline_manager`, `activitypub.media_cache`,
  `activitypub.resolve_service` (remote actor/object lookup), `activitypub.form_alter`.

## Federation routes (`activitypub.routing.yml`)
- `activitypub.inbox` `POST /user/{user}/activitypub/{actor}/inbox` → `InboxController::inbox`.
- `activitypub.shared_inbox` `POST /activitypub/inbox` → `InboxController::sharedInbox` (gated by
  `inbox_shared_enabled`).
- `activitypub.outbox` `GET /user/{user}/activitypub/{actor}/outbox`, `.followers`, `.following`.
- `activitypub.user.self.json` `GET /user/{user}` (actor JSON), `.instance.*`, WebFinger via subscriber.
- Admin UI under `/admin/config/services/activitypub` (`activitypub.settings`, types, activities,
  timeline items, queue, cache).

## Permissions (`activitypub.permissions.yml`)
`administer activitypub settings`, `administer activitypub types`, `allow users to enable activitypub`,
`publish to site-wide actor`, `resolve remote activitypub activities and actors`,
`manage all activitypub activities`, `manage all activitypub timeline items` (last two `restrict access`).

## Drush
`ActivityPubCommands` (`src/Commands/ActivityPubCommands.php`) — prepare/handle outbox & inbox queues.

## Solution docs
- Configuration & settings: [agent/config/settings.md](config/settings.md)
- Federation model (inbox/outbox, signatures, queues, types): [agent/federation/inbox-outbox.md](federation/inbox-outbox.md)
- Entities (Actor / Activity / Type / TimelineItem): [agent/entities/entities.md](entities/entities.md)

## Submodules (documented separately under `../modules/<name>/1.0.x/`)
`activitypub_api`, `activitypub_mastodon_api`, `activitypub_comment`, `activitypub_reader`,
`activitypub_scheduler`.
