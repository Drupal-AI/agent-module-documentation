<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Reader — Personal Reader integration

## Enable
`drush en activitypub_reader` (requires the contrib `reader` module — `drupal/reader`). Set posts per
timeline at `/admin/config/services/activitypub/reader` (`activitypub_reader.settings` →
`timeline_limit`, default 20). The reader UI itself (routes, theming, `/reader`) is provided by the
`reader` module; this submodule only feeds it ActivityPub data.

## Hook wiring (`activitypub_reader.module` → `Reader` service)
| Reader hook | `Reader` method | Purpose |
|---|---|---|
| `hook_reader_channels` | `getChannels()` | Register home / notifications / direct / bookmarks channels |
| `hook_reader_sources($op)` | `getSourcesPage($op)` | List/add/remove followed actors (sources) |
| `hook_reader_timeline($id,$search)` | `getTimeline()` | Build a channel timeline (with optional search) |
| `hook_reader_author($id)` | `getAuthorTimeline()` | An author's posts |
| `hook_reader_post($id)` | `getPost()` | A single post + context |
| `hook_reader_timeline_actions($id)` / `..do_timeline_action($action,$id)` | `getTimelineActions()` / `doTimelineAction()` | Per-item actions |
| `hook_reader_post_actions($id,$item)` / `..do_post_action($action,$id,$items)` | `getPostActions()` / `doPostAction()` | Per-post actions |

## Data source
`Reader` reads `activitypub_timeline_item` + `activitypub_activity` through
`activitypub.timeline_manager` (`getHomeTimelineItems`, `getNotificationTimelineItems`,
`getBookmarks`, `getDirectMessageTimelineItems`) scoped to `currentUser`. Each item's rendered body
comes from the activity payload / remote content object (`$item['content'] = (object)['html' => …]`);
attachments and avatars are resolved and cached via `activitypub.media_cache` and
`activitypub.utility`. Pagination uses the injected `pager.manager` + `timeline_limit`.

## Actions
Timeline/post actions map to outbound ActivityPub operations through `activitypub.outbox` and
`TimelineManager`: like (Favourite), announce (Boost), reply, bookmark/unbookmark, mute/unmute, and
delete (own items). Follow/unfollow of remote actors is handled from the sources page
(`getSourcesPage()`), which also surfaces pending (unpublished) follow requests as
"Waiting for confirmation".

## Cache
Inbound activity processing in the parent module invalidates
`['reader:timeline:activitypub_reader', 'reader:channels']`, so new inbound content appears in the
reader without manual clears.
