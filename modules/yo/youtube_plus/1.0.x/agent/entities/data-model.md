<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YouTube Plus — data model

Two distinct layers: (1) the **channel config entity** (import configuration), and (2) the
**imported content** (a node type + two vocabularies shipped as optional config).

## 1. `youtube_plus_channel` — config entity

`src/Entity/YoutubePlusChannelEntity.php` — `@ConfigEntityType(id = "youtube_plus_channel",
config_prefix = "youtube_plus")`, interface `YoutubePlusChannelInterface`. `config_export`: **`id`,
`name`, `type`** only.

- `id` — the resolved **YouTube channel ID** (also the entity id/machine name).
- `name` — human label (`getName()` / `setName()`).
- `type` — `0` = configured by channel ID, `1` = by custom URL/username.
- Handlers: `list_builder` = `YouTubePlusListBuilder`; forms `add-form`/`edit-form` = `ChannelForm`,
  `delete-form` = `ChannelDeleteForm`. Note the annotation's `admin_permission` is the typo'd
  **`administrater youtube plus`** (never matches the real permission; routing enforces access
  instead — see api/service.md).

**`ChannelForm`** (`src/Form/ChannelForm.php`, `extends EntityForm`): fields `name`, a `type` radios
(Id/Url, new entities only), and `channel_id` / `channel_url` toggled by `#states`. `validateForm()`
requires an API key and rejects values containing a space or the substring `http`. On submit, if
`channel_id` is empty it resolves the id from the custom URL via
`YouTubePlusUtils::getChannelByCustomURL()` (`forUsername`), then saves `id`.

**`YouTubePlusListBuilder`** (`src/Controller/YouTubePlusListBuilder.php`): table with Channel Name /
Channel ID columns and row operations **Edit / Import / Rollback / Delete** (Import & Rollback link
to the import/rollback controller routes).

## 2. Imported content — shipped `config/optional/`

Installed automatically when node/taxonomy/link are present; removed on uninstall.

### Node type `ytp_video` ("YouTube Plus: Video")
`new_revision: true`. One node per imported video. Fields (`field_ytp_*`, all cardinality 1):

- `field_ytp_video_id` — the YouTube video ID (used as the dedupe key on re-import).
- `field_ytp_description` — video description.
- `field_ytp_url` — **link**, the `watch?v=` URL.
- `field_ytp_published` — **timestamp** of the video's `publishedAt`.
- `field_ytp_thumbnail_default|medium|high|standard|maxres` — five **link** fields, thumbnail URLs
  (standard/maxres set only when the API returns them).
- `field_ytp_channel` — entity_reference to a `ytp_channels` term.
- `field_ytp_playlists` — entity_reference (to `ytp_playlists` terms); accumulates every playlist a
  video appears in.

### Vocabulary `ytp_channels` ("YouTube Plus: Channels")
One term per imported channel. Fields: `field_ytp_channel_id`, `field_ytp_custom_url`,
`field_ytp_url` (link), `field_ytp_item_count` (upload count), `field_ytp_playlist_id` (the channel's
"uploads" playlist), and `field_ytp_thumbnail_default|medium|high`. The term `name`/`description` hold
the channel title/description.

### Vocabulary `ytp_playlists` ("YouTube Plus: Playlists")
One term per playlist. Fields: `field_ytp_playlist_id`, `field_ytp_url` (link),
`field_ytp_item_count`, `field_ytp_channel` (reference back to the channel term), and
`field_ytp_thumbnail_default|medium|high`.

The module also ships default + teaser entity view displays and default form displays for these.

## Install / uninstall (`youtube_plus.install`)

- `hook_schema()` declares a table **`youtube_plus_log`** (`id`, `channel_id`, `last_import`) meant to
  hold last-import timestamps. (The current import code does not actually write to it.)
- `hook_uninstall()` first calls `youtube_plus.actions::rollback()` (deletes all imported
  nodes/terms), then hard-deletes the module's optional config by issuing raw
  `DELETE ... LIKE` queries against the `config` and `cache_config` tables for every shipped
  `field.*` / `node.type.*` / `taxonomy.vocabulary.*` / `youtube_plus.settings` config name.
