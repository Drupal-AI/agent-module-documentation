<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub — federation model (inbox, outbox, signatures, queues)

## Actors, keys & discovery
Each user can enable one or more `activitypub_actor` entities. `Signature::generateKeys()` writes a
4096-bit RSA key pair per actor under the private keys path. The actor JSON is served at
`GET /user/{user}` (`activitypub.user.self.json`, `_format: activity_json`) and
`GET /user/{user}/activitypub/{actor}` (`UserController::self`). WebFinger (`@name@host`) discovery is
handled by `EventSubscriber/WebfingerProfileSubscriber.php`; instance-level actor at
`/activitypub/instance`. `StackMiddleware/FormatSetter.php` sets the `activity_json` request format
from the `Accept: application/activity+json` header.

## Outbox delivery (`Services/ProcessClient.php`, `Services/Outbox.php`)
1. A published outbox `activitypub_activity` is queued via `ProcessClient::createQueueItem()`
   (`ACTIVITYPUB_OUTBOX_QUEUE`). `activitypub_cron()` (when `process_outbox_handler == 'cron'`) or
   Drush calls `prepareOutboxQueue()`.
2. `prepareOutboxQueue()` calls `$activity->buildActivity()` (delegates to the type plugin's `build()`),
   resolves targets (explicit `to`, plus followers when the followers-URL is addressed) and creates
   per-host `ACTIVITYPUB_OUTBOX_SEND_QUEUE` items.
3. `handleOutboxQueue()` resolves each target actor's `inbox`/`sharedInbox` via the ActivityPhp
   `Server` (`Utility::getServer()`), builds a SHA-256 `digest`, signs with
   `Signature::getSignatureHeaders()` (keyId `<actor>#main-key`, `rsa-sha256` over
   `(request-target) host date digest`) and `POST`s the JSON to the remote inbox. 404/410/timeout/
   cert failures unpublish the related Follow/Accept (`unpublishFollowsAndAcceptsByActor()`).

## Inbox intake (`Controller/InboxController.php`)
`activitypub.inbox` (`POST /user/{user}/activitypub/{actor}/inbox`) and `activitypub.shared_inbox`
(`POST /activitypub/inbox`, only when `inbox_shared_enabled`) both call `handleInboxRequest()`:
1. Decode payload; require non-empty `actor` + `id`. Apply per-user and site-wide
   `inbox_blocked_domains` (`domainIsBlocked()` → 403 if blocked).
2. `Signature::verifySignature($request, $actor, server)` — fetches the claimed actor's public key
   through the ActivityPhp `Server` and RSA-verifies the signed headers. The boolean result becomes
   the activity's `status` (published) flag; for timeline types a followee fallback may set it.
3. `Utility::createActivityFromPayload()` builds an inbox `activitypub_activity`;
   `$activity->preInboxSave($doSave)` runs every type plugin's `onActivityInboxPreSave()`; if `$doSave`
   the activity is saved and `postSave()` runs each plugin's `onActivityPostSave()`.
4. Published notification-type activities create `activitypub_timeline_item`s
   (`TimelineManager::createTimelineItem()`); reader caches are invalidated. Returns `202`.

## Type plugins (`@ActivityPubType`) — where activity semantics live
- `Core` (`Plugin/activitypub/type/Core.php`): `inbox_ignore_types`, Update handling, dedup, resolves
  `object`/`inReplyTo` to a local entity (`Utility::getEntityFromUrl()`), sets Followers/Private
  visibility.
- `StaticTypes` (`Plugin/activitypub/type/StaticTypes.php`): **Follow** → creates+queues an Accept in
  `onActivityPostSave()`; **Accept** → marks the matching Follow published (+ optional backfill);
  **Undo(Follow)** and **Delete** → delete matching stored activities; **Move** → re-points followers.
  `build()` renders Follow/Accept/Undo/Delete JSON for the outbox.
- `DynamicTypes`: maps a content entity/bundle to a `Note` (or configured object) with field mapping;
  provides the `/{entity}?_format=activity_json` route via `Routing/ActivityPubRoutes.php`.
- `Context`: fetches remote reply/like/announce context for the timeline (queued, see
  `Activity::canBeQueued()`).

## Queues (`activitypub.module`)
`ACTIVITYPUB_OUTBOX_QUEUE` (build), `ACTIVITYPUB_OUTBOX_SEND_QUEUE` (deliver),
`ACTIVITYPUB_INBOX_QUEUE` (`handleInboxQueue()` → `Activity::doInboxProcess()` → plugin
`doInboxProcess()`, e.g. Follow backfill, comment creation). Run via cron handlers or Drush.

## Remote lookup / resolution (`Services/ResolveService.php`)
`resolveQuery($uri)` resolves a `@user@host` handle (WebFinger) or a direct object URL to a remote
Note/Person; used by the search plugin (`Plugin/Search/ActivitypubSearch.php`) and the API submodules.
Gated for end users by the `resolve remote activitypub activities and actors` permission.
`getActorUrlByHandle()` resolves a handle to its canonical actor URL via `WebFingerFactory`.

## Actor / relationship housekeeping
`activitypub_entity_predelete()` → `Utility::onEntityDelete()`: deleting a user removes its actors;
deleting an actor deletes its keys and activities; deleting a federated content entity emits an outbox
Delete (`StaticTypes::onEntityDelete()`).
