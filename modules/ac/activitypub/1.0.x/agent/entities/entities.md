<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub — entities & plugin type

## `activitypub_actor` (content entity)
`src/Entity/Actor.php` (`ActorInterface`). A Fediverse actor (Person, or the site Instance actor)
owned by a Drupal user (`uid`). Fields include `name` (machine name used in URLs and key path),
display name, summary, type, blocked-domains, status. Custom storage
`src/Entity/Storage/ActorStorage.php` + `ActorStorageSchema.php`; loaders such as
`loadActorByOwnerIdAndActorUrl()`, `loadActorByActorUrl()`, `loadActorByEntityIdAndType()`.
Param converter `activitypub_actor` (`src/ParamConverter/ActorConverter.php`) resolves the `{activitypub_actor}`
route slug. Constants: `ACTOR_PERSON`, `ACTOR_INSTANCE_NAME`.

## `activitypub_activity` (content entity)
`src/Entity/Activity.php` (`ActivityInterface`), base table `activitypub_activity`,
`persistent_cache = FALSE`. Represents one ActivityStreams activity in a collection.
Key base fields: `collection` (INBOX/OUTBOX/UNDEFINED), `external_id`, `type` (Create, Like, Announce,
Follow, Accept, Delete, Undo, Move…), `actor`, `object`, `reply`, `config_id` (the `activitypub_type`
id), `entity_type_id`/`entity_id` (local target), `payload` (raw JSON), `context`, `to`,
`visibility` (`VISIBILITY_PUBLIC|FOLLOWERS|UNLISTED|PRIVATE`), `mute`, `processed`, `queued`, and
`status` (the `published` key). Lifecycle hooks delegate to every type plugin:
`preInboxSave()`/`preOutboxSave()` (→ `onActivityInboxPreSave`/`onActivityOutboxPreSave`),
`postSave()` (→ `onActivityPostSave`), `delete()` (→ `onActivityDelete`), `onEntityDelete()`.
`buildActivity()`/`doInboxProcess()` dispatch to the `config_id`'s plugin. `undo()` creates+queues an
Undo. Storage: `src/Entity/Storage/ActivityStorage.php` (rich query helpers:
`getActivities`, `getFolloweesByActor`, `isFolloweeByUserAndActor`, `getActivitiesByTypeActorAndObject`…).
Routes via `ActivityRouteProvider`; admin list `ActivityListBuilder`; views data `ActivityViewsData`.
Delete actions: `Plugin/Action/DeleteActivity.php`.

## `activitypub_timeline_item` (content entity)
`src/Entity/TimelineItem.php` (`TimelineItemInterface`). A per-user pointer (`uid`, `fid`=activity id,
`aid`, `timeline`, `is_read`, `mute`) placing an activity into a timeline:
`TIMELINE_DEFAULT` (General), `TIMELINE_NOTIFICATION`, `TIMELINE_DM`, `TIMELINE_BOOKMARK`,
`TIMELINE_PUBLIC`. Managed by `Services/TimelineManager.php`
(`createTimelineItem`, `getHomeTimelineItems`, `getNotificationTimelineItems`,
`getPublicTimelineItems`, `getBookmarks`, `getDirectMessageTimelineItems`). Storage
`src/Entity/Storage/TimelineItemStorage.php`; delete action `Plugin/Action/DeleteTimelineItem.php`.

## `activitypub_type` (config entity)
`src/Entity/Type.php` (`TypeInterface`). Maps content to an ActivityStreams object by binding an
`@ActivityPubType` plugin (`plugin.id` + `plugin.configuration`). `locked`/`can_edit_when_locked`
protect shipped types; `api` marks a type as API-exposed. Access handler
`TypeAccessControlHandler.php`; forms `ActivityPubTypeForm.php` / `ActivityPubTypeDeleteForm.php`.

## `@ActivityPubType` plugin type
Annotation `src/Annotation/ActivityPubType.php`; manager `src/Services/Type/TypePluginManager.php`
(`plugin.manager.activitypub.type`); base `src/Services/Type/TypePluginBase.php`
(`TypePluginInterface`). Discovered from `Plugin/activitypub/type/*`. Core plugins: `activitypub_core`,
`activitypub_static_types`, `activitypub_dynamic_types`, `activitypub_context`. Submodules add
`activitypub_comment` and `activitypub_scheduler`. A plugin implements `build()` (outbox JSON),
`doInboxProcess()`, and the `onActivity*`/`onEntityDelete` lifecycle callbacks.

## Other provided plugins
- Block `Plugin/Block/FollowBlock.php` — a follow button/form for an actor.
- Search `Plugin/Search/ActivitypubSearch.php` — search/resolve remote actors and objects.
- Actions `Plugin/Action/DeleteActivity.php`, `DeleteTimelineItem.php` (+ `system.action.*` config).
- Views: `config/optional/views.view.activitypub_*` (user/admin activities & timelines).
- Field `field_activitypub_actor_metadata` (`config/optional/field.*`) for profile PropertyValue rows.
