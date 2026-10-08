<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VideoJS Media provides a reusable `videojs_media` content entity that renders a VideoJS player, with a bundle per source type — Local Video, Local Audio, Remote Video, Remote Audio and YouTube — each carrying only the fields it needs.
---
Rather than a block or field formatter, video/audio is modelled as a full content entity (revisions, translations, Views, entity reference), so editors create a media item once and reference it from any content type. Each bundle ships its own fields (e.g. `field_media_file` + `field_poster_image` + `field_subtitle` for local types, `field_remote_url` for remote, `field_youtube_url` for YouTube) and default/teaser view displays; a `template_preprocess_videojs_media` builds the render variables and bundle/view-mode CSS classes, and `hook_menu_links_discovered_alter` adds a Navigation-module entry when present. Subtitles/captions fields support ADA/508 accessibility. The module depends on `file_upload_secure_validator` to harden uploaded media files.

Access is fully permission-based per bundle via `VideoJsMediaAccessControlHandler`: `administer videojs media` grants everything; otherwise view checks the published state against `view <bundle> videojs media` / `view unpublished <bundle> videojs media`, and update/delete check `edit|delete any <bundle> videojs media` or the `own` variants combined with ownership. Admin/type management is gated by `administer videojs media types`. Setup: enable the module, grant per-bundle create/edit/view permissions, create items at `/videojs-media/add`, and add an entity-reference field to content types that should embed them.
---
Create a Local Video media item.
- Create a Local Audio media item.
- Embed a Remote Video by URL.
- Embed a Remote Audio stream by URL.
- Embed a YouTube video by URL.
- Add a poster image to a player.
- Attach subtitle/caption tracks for accessibility.
- Reference a VideoJS Media item from a node via entity reference.
- Reuse one media item across many pieces of content.
- Configure per-bundle view modes (default/teaser).
- Grant `create <bundle> videojs media` to editors.
- Allow editors to edit only their own media (`edit own …`).
- Let managers edit any media (`edit any …`).
- Restrict deletion with `delete any/own <bundle> videojs media`.
- Publish/unpublish media items and gate viewing accordingly.
- Manage bundles/fields under VideoJS Media types.
- Add custom fields per bundle via Field UI.
- Place the VideoJS Media block.
- List and filter media in Views by bundle.
- Add VideoJS Media to the Navigation admin menu.
- Translate media items where languages are enabled.