<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Reader (activitypub_reader) — agent index

Submodule of **activitypub**. Implements the Personal Reader (`drupal/reader`) hook API to surface
ActivityPub timelines and interactions inside the reader UI for a logged-in user.

## Dependencies
`reader`, `activitypub`.

## What it provides
- Service `activitypub_reader.reader` (`src/Reader.php`, class `Reader`) injected with config factory,
  entity type manager, form builder, current user, request stack, pager, date formatter, and the parent
  services `activitypub.utility`, `activitypub.media_cache`, `activitypub.timeline_manager`,
  `activitypub.outbox`.
- `activitypub_reader.module` implements the reader hooks, each delegating to the service:
  `hook_reader_channels` → `getChannels()`, `hook_reader_sources` → `getSourcesPage($op)`,
  `hook_reader_timeline` → `getTimeline($id,$search)`, `hook_reader_author` → `getAuthorTimeline($id)`,
  `hook_reader_post` → `getPost($id)`, `hook_reader_timeline_actions`/`hook_reader_do_timeline_action`,
  `hook_reader_post_actions`/`hook_reader_do_post_action`.
- Settings form `activitypub_reader.settings` (`/admin/config/services/activitypub/reader`,
  `administer activitypub settings`). Config `activitypub_reader.settings` → `timeline_limit` (default 20).

## Timelines/channels
Home (`TIMELINE_DEFAULT`), Notifications, Direct messages, Bookmarks — built from
`activitypub_timeline_item`/`activitypub_activity` via `TimelineManager`. Remote content and images are
resolved/proxied through the parent utility and `activitypub.media_cache`. Reader cache tags
`reader:timeline:activitypub_reader`, `reader:channels` are invalidated by the parent inbox controller.

## Solution doc
- Reader hooks, timelines & actions: [agent/integration/reader.md](integration/reader.md)
