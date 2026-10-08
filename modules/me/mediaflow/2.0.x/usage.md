<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mediaflow connects Drupal to the Mediaflow digital asset management platform so editors can browse, search and import Mediaflow assets into Drupal's media system.

---

The module authenticates to the Mediaflow API with a client id, client secret and refresh token (OAuth2 refresh-token grant); access tokens are cached in an expirable key-value store and auto-renewed by `MediaflowFetcher`. It supplies a `mediaflow` media source, custom field type/widget/formatter (`MediaflowItem`), a CKEditor 5 plugin for embedding assets in rich text, and form-API elements (`MediaflowSelector`) that open the Mediaflow picker. Selected images are downloaded into `public://mediaflow/` and a `UsageManager` reports usage back to Mediaflow; a CSP event subscriber whitelists Mediaflow resources for the Content-Security-Policy module. Video embeds can be rendered by a configurable method.

Configuration is at `/admin/config/media/mediaflow` behind `administer mediaflow` (restrict access), storing `client_id`, `client_secret`, `refresh_token`, `set_alt_text`, `allow_crop` and `method`. A second permission, `use mediaflow`, gates the `/mediaflow/token` helper route; the `/mediaflow/add_media` import route is admin-gated.

---
- Create a Mediaflow API app and obtain client id, secret and refresh token.
- Enter credentials at `/admin/config/media/mediaflow`.
- Enforce alt-text entry on imported assets.
- Choose the video embed method.
- Add a Mediaflow field to a content type using the Mediaflow widget.
- Create a media type backed by the `mediaflow` media source.
- Browse and search the Mediaflow library from the editor UI.
- Import a Mediaflow image into Drupal as a managed file.
- Embed a Mediaflow asset in CKEditor 5 rich text.
- Render Mediaflow assets with the default or custom formatter.
- Report Drupal usage of an asset back to Mediaflow.
- Remove a usage record when content is deleted.
- Auto-renew the Mediaflow access token before expiry.
- Clear a cached access token to force re-authentication.
- Whitelist Mediaflow hosts via the Content-Security-Policy module.
- Restrict who can configure the integration with `administer mediaflow`.
- Grant editors asset use via the `use mediaflow` permission.
- Allow cropping of imported images where supported.
- Store imported assets under `public://mediaflow/`.
- Troubleshoot empty libraries by re-checking credentials/permissions.
