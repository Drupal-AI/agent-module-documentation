<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JW Platform Media Source connects Drupal media to the JW Player v2 APIs so editors can browse a JW Player site's library and embed videos through a field, a block, or a CKEditor 5 plugin.

Configure your JW Player API v2 key and site ID at `/admin/config/media/jw-player-media-source` (`jwmedia.settings`, permission `administer jw player media source`). A `/admin/content/jw-media` listing (permission `administer site configuration`) renders `MediaViewForm`, which queries `https://api.jwplayer.com/v2/sites/{id}/media/` (with optional title search) and `https://cdn.jwplayer.com/v2/media/{id}` for thumbnails, authenticating with a Bearer token. Selecting a video yields a `<script src="https://cdn.jwplayer.com/players/{mediaID}-{playerID}.js">` embed rendered by the `JwVideoScriptFormatter` field formatter, the `JwVideoBlock` block, or the CKEditor 5 embed plugin.

Security/operational notes: all admin surfaces are permission-gated (no anonymous routes). The Guzzle calls in `MediaViewForm.php` and `JWPlayerMediaSourceSettings.php` place a `'verify' => FALSE` key **inside the `headers` array** rather than at the request-options top level, so it is an inert header and TLS verification stays **on** — a harmless bug, not a disabled-TLS issue.
---
Browse and embed JW Player v2 videos in Drupal through a media source, field, block and CKEditor 5 plugin.
---
- Enter the JW Player API v2 key and site ID at `/admin/config/media/jw-player-media-source`.
- Grant `administer jw player media source` to editors who configure credentials.
- Browse the JW Player library at `/admin/content/jw-media`.
- Search the remote library by video title from the media view form.
- Page through remote results (10 per page) in the listing.
- Add the JW video field to a content type to embed a chosen video.
- Use the `JwVideoWidget` field widget to pick a video ID.
- Render embeds with the `JwVideoScriptFormatter` field formatter.
- Place the `JwVideoBlock` block to embed a video in a region.
- Embed videos inside CKEditor 5 with the bundled plugin.
- Open the modal picker via the `entity.jwmedia.modal` route.
- Pull per-video thumbnails from `cdn.jwplayer.com/v2/media/{id}`.
- Store the selected media ID on the field type `JwVideoItem`.
- Set the player ID so embeds load the correct JW player script.
- Confirm credentials are complete before the listing renders (guarded).
- Reconfigure the site ID to switch which JW Player library is browsed.
- Review the CKEditor 5 config in `jw_player_media_source.ckeditor5.yml`.
- Restrict `/admin/content/jw-media` to admins via `administer site configuration`.
