<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mediaflow

## 1. Enable
`drush en mediaflow -y` (requires core `media` and `ckeditor5`).

## 2. Mediaflow credentials
Create/collect an API app in Mediaflow to get an OAuth2 **client id**, **client secret** and a
long-lived **refresh token**. Enter them at `/admin/config/media/mediaflow`
(permission `administer mediaflow`), config object `mediaflow.settings`:
- **Client ID** → `client_id`
- **Client secret** → `client_secret`
- **Refresh token** → `refresh_token`
- **Enforce alt-texts** → `set_alt_text`
- **Video embed method** → `method`
- (crop toggle) → `allow_crop`

`MediaflowFetcher` exchanges the refresh token for an access token and caches it in an expirable
key-value store, renewing automatically ~5 minutes before expiry.

## 3. Use assets
- **Media type:** add a media type whose source is **Mediaflow** (`mediaflow`).
- **Field:** add the Mediaflow field to a content type and pick the Mediaflow widget; the
  `MediaflowSelector` element opens the Mediaflow picker.
- **CKEditor 5:** enable the Mediaflow button in a text format's toolbar to embed assets inline.
- Imported images are written to `public://mediaflow/`; usage is reported back to Mediaflow by
  `mediaflow.usage_manager`.

## 4. CSP (optional)
With the Content-Security-Policy module enabled, `mediaflow.csp_subscriber` automatically
whitelists Mediaflow resource hosts.
