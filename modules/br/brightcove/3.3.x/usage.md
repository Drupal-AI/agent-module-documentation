Brightcove Video Connect integrates a Drupal site with the [Brightcove](https://www.brightcove.com/) Video Cloud platform: it authenticates via OAuth client-credentials, mirrors Brightcove videos, playlists, players, custom fields, and text tracks into local Drupal entities, and can push new videos back up via Dynamic Ingest.

---

You register one or more **API Clients** (`brightcove_api_client` config entities) at
`/admin/config/media/brightcove_api_client`, each holding a Brightcove Account ID, Client ID, and
secret. `BrightcoveAPIClient::authorizeClient()` exchanges those for an OAuth access token
(`Client::authorize()`, from the `brightcove/api` PHP SDK) cached in an expirable key-value store,
and `BrightcoveUtil` exposes the resulting CMS / Dynamic Ingest / Player Management API wrappers.
Content is synced Brightcove→Drupal through queues (via cron, the `brightcove:sync-all` Drush
command, or the Status Overview page) that populate content entities `brightcove_video`,
`brightcove_playlist`, `brightcove_text_track`, and config-ish entities `brightcove_player` /
`brightcove_custom_field`. Editors create/edit videos locally and the module uploads them to
Brightcove. Two inbound callback routes support push updates: `brightcove/ingestion-callback/{token}`
(protected by a per-video expirable token via a custom `_brightcove_csrf_callback_access_check`) and
`brightcove/notification-callback` (subscription notifications). Subscriptions
(`brightcove_subscription`) register a Brightcove notification endpoint so remote changes flow back.
The module ships a video tags vocabulary, image style, and two Views, integrates Token, and supports
proxied API calls, a Media source, and In-Page Experience galleries through its three submodules
(`brightcove_proxy`, `media_brightcove`, `brightcove_gallery`). A cron settings form and a
per-client "max custom fields" limit round out configuration.

---

- Authenticate a Drupal site to a Brightcove Video Cloud account via OAuth client credentials.
- Manage multiple Brightcove accounts from one site with several API clients.
- Sync Brightcove videos into local `brightcove_video` entities for display and reference.
- Sync Brightcove playlists into `brightcove_playlist` entities.
- Mirror Brightcove players and custom fields locally.
- Import and manage video text tracks (captions/subtitles) as entities.
- Upload new videos from Drupal to Brightcove via Dynamic Ingest.
- Receive ingestion-complete callbacks to finalize a pushed video (token-protected).
- Subscribe to Brightcove change notifications so remote edits update local entities.
- Run a full Brightcove→Drupal sync on cron.
- Trigger a manual full sync with `drush brightcove:sync-all` (alias `bcsa`).
- Monitor and re-queue sync operations from the Status Overview report.
- Embed a Brightcove player for a video via field formatters/templates.
- Reference Brightcove videos from nodes using inline entity forms.
- Tag Brightcove videos with the shipped `brightcove_video_tags` vocabulary.
- List videos/playlists with the bundled Views (all, and by API client).
- Use a "Brightcove Video" media source for reusable media (media_brightcove submodule).
- Build In-Page Experience galleries (brightcove_gallery submodule, experimental).
- Route all Brightcove API traffic through an HTTP/SOCKS proxy (brightcove_proxy submodule).
- Use Token replacements for Brightcove entity fields.
- Limit the number of custom fields fetched per API client.
- Disable Brightcove's cron sync while keeping manual/queue sync available.
- Restrict who can create, edit, delete, or view Brightcove videos and playlists via permissions.
- Automatically clean up video poster/thumbnail file references when files are deleted.
