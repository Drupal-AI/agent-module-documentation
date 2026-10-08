<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure JW Platform Media Source

1. `composer require drupal/jw_player_media_source` and enable it (`drush en jw_player_media_source`).
2. Visit `/admin/config/media/jw-player-media-source` (`jwmedia.settings`, permission `administer jw player media source`).
3. Enter the **JW Player API v2 key**, the **site ID(s)** (`js_ms_ids`), the secret (`jw_ms_secret`) and enable the source (`jw_ms_enable`). Config object: `jw_player_media_source.settings`.

Embedding paths:
- **Field** — add the JW video field (type `JwVideoItem`) to a bundle; edit with `JwVideoWidget`; display with `JwVideoScriptFormatter`.
- **Block** — place `JwVideoBlock` in a region.
- **CKEditor 5** — enable the bundled plugin (`jw_player_media_source.ckeditor5.yml`) in a text format's toolbar.

Browsing / picking:
- `/admin/content/jw-media` (`entity.jwmedia.collection`, perm `administer site configuration`) renders `MediaViewForm`, which calls
  `https://api.jwplayer.com/v2/sites/{id}/media/?q=title:{q}&page={n}&page_length=10&sort=created:dsc`
  with an `Authorization: Bearer {secret}` header, and fetches thumbnails from `https://cdn.jwplayer.com/v2/media/{id}`.
- `/admin/content/jw-media-modal` (`entity.jwmedia.modal`) opens the picker in a modal.

The final embed is `https://cdn.jwplayer.com/players/{mediaID}-{playerID}.js`.

Note: the Guzzle `'verify' => FALSE` in these forms is placed inside the `headers` array, so it does not disable TLS verification.
