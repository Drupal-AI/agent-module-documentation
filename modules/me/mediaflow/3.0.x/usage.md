<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mediaflow connects Drupal to the Mediaflow digital asset management platform so editors can browse, search and import Mediaflow assets into Drupal's media system.

---

The module authenticates to the Mediaflow API (`https://api.mediaflow.com/1`) with a client id, client secret and refresh token (OAuth2 refresh-token grant). In 3.0.x these three credentials are read through Key entities (`drupal/key`) — the settings form stores only the *id* of a Key, so the recommended Environment provider keeps the secret in `MEDIAFLOW_CLIENT_ID`, `MEDIAFLOW_CLIENT_SECRET` and `MEDIAFLOW_REFRESH_TOKEN` on the server. `MediaflowFetcher` exchanges the refresh token for an access token, caches it in an expirable key-value store and auto-renews it ~5 minutes before expiry. The module supplies a `mediaflow` media source, a `mediaflow_item` field type with matching widget/formatter, a CKEditor 5 plugin for embedding assets in rich text, and a `mediaflow_selector` Form API element that opens the Mediaflow picker. Picked assets are stored as `mediaflow_asset` config/content entities (3.0.x migrates the legacy `mediaflow` table into this entity); downloaded files are written into the target media type's source-field directory under `mediaflow/<resource id>/`, and a `UsageManager` reports usage back to Mediaflow when the media is created and retracts it when the media is deleted. Imports are bounded by a per-user flood limit (`import_limit` per `import_window` seconds, default 30/hour). A CSP event subscriber whitelists Mediaflow resource hosts for the Content-Security-Policy module. Video is embedded as a Mediaflow iframe; the HTML and SVG sanitizers strip embeds and downloaded SVGs down to a strict allowlist.

Configuration is at `/admin/config/media/mediaflow` behind `administer mediaflow` (restricted). The config object `mediaflow.settings` stores `client_id_key`, `client_secret_key`, `refresh_token_key`, `set_alt_text`, `allow_crop`, `allowed_extensions`, `import_limit` and `import_window`. A second restricted permission, `use mediaflow`, gates the file selector: the `/mediaflow/token` route (hands a short-lived access token to the picker JS), the `/mediaflow/csrf-token` route, and the POST-only `/mediaflow/add_media` import route (CSRF-token checked, flood-limited, media-create and field-edit access checked). Downloads are constrained to an HTTPS host allowlist and validated by extension, detected MIME type, size and Drupal's file validators; a blocklist rejects executable extensions and active-content MIME types.

---
- Create a Mediaflow API app and obtain client id, secret and refresh token.
- Store each credential in a Key entity (Environment provider recommended) and select it on the settings form.
- Supply credentials from environment variables so the secret stays off disk and out of config exports.
- Enter credentials at `/admin/config/media/mediaflow`.
- Enforce alt-text entry on imported assets.
- Restrict which file extensions may be imported via the fallback `allowed_extensions` list.
- Add a Mediaflow field to a content type using the Mediaflow widget.
- Create a media type backed by the `mediaflow` media source.
- Browse and search the Mediaflow library from the editor UI or the Media Library.
- Import a Mediaflow image into Drupal as a managed file.
- Embed a Mediaflow asset in CKEditor 5 rich text.
- Embed a Mediaflow video as an iframe.
- Render Mediaflow assets with the default or image-style formatter.
- Report Drupal usage of an asset back to Mediaflow on media creation.
- Retract a usage record when the media is deleted.
- Auto-renew the Mediaflow access token before expiry.
- Clear a cached access token to force re-authentication (re-saving the settings form).
- Rate-limit how many assets a single editor may import per time window.
- Whitelist Mediaflow hosts via the Content-Security-Policy module.
- Restrict who can configure the integration with `administer mediaflow`.
- Grant editors asset use via the `use mediaflow` permission.
- Migrate plaintext 2.x credentials into Key entities on update.
- Store imported assets under the media type's source-field file directory.
- Troubleshoot empty libraries by re-checking credentials and library permissions in Mediaflow.
- Review the status report for credentials still kept inside Drupal configuration.
