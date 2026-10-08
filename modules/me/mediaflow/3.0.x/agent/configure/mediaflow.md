<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mediaflow

## 1. Enable
`drush en mediaflow -y` (requires core `media`, `media_library`, `ckeditor5` and the contrib `key` module; Composer also pulls in `enshrined/svg-sanitize`).

## 2. Mediaflow credentials (Key entities)
Create/collect an API app in Mediaflow to get an OAuth2 **client id**, **client secret** and a
long-lived **refresh token**. In 3.0.x each credential is read through a **Key entity**
(`drupal/key`), so the settings form stores only the Key's id, never the secret itself.

Recommended: the **Environment** key provider. Put the values in environment variables and point
each Key at the variable name:
- `MEDIAFLOW_CLIENT_ID` → Client ID key → `client_id_key`
- `MEDIAFLOW_CLIENT_SECRET` → Client secret key → `client_secret_key`
- `MEDIAFLOW_REFRESH_TOKEN` → Refresh token key → `refresh_token_key`

Select the three keys at `/admin/config/media/mediaflow` (permission `administer mediaflow`),
config object `mediaflow.settings`. Other settings on the same form:
- **Enforce alt-texts** → `set_alt_text`
- **Allowed file extensions** (fallback list; executable extensions are always blocked) → `allowed_extensions`
- (crop toggle) → `allow_crop`
- Import rate limit → `import_limit` / `import_window` (default 30 imports per 3600 s)

`MediaflowFetcher` exchanges the refresh token for an access token and caches it in an expirable
key-value store, renewing automatically ~5 minutes before expiry. Saving the form clears the
cached token.

### Upgrading from 2.x
`mediaflow_update_10001` migrates the old plaintext `client_id` / `client_secret` / `refresh_token`
config values into Key entities: into Environment-provider keys when the matching environment
variables are set, otherwise into Config-provider keys that preserve the existing values so the
update never blocks. Drupal's status report then flags any credential still kept inside Drupal
configuration or state so it can be moved to an environment-backed provider and rotated.

## 3. Use assets
- **Media type:** add a media type whose source is **Mediaflow** (`mediaflow`); `mediaflow_update_10005` can create a default one.
- **Field:** add the Mediaflow field (`mediaflow_item`) to a content type and pick the Mediaflow widget; the `mediaflow_selector` element opens the Mediaflow picker.
- **Media Library:** the source also registers a Media Library add-form, so assets can be picked from the Library.
- **CKEditor 5:** add the Mediaflow button to a text format's toolbar and set the plugin's media type (`media_bundle`) to embed assets inline.
- Imported images are written under the source field's file directory in `mediaflow/<resource id>/`; usage is reported back to Mediaflow by `mediaflow.usage_manager` on media insert and retracted on delete.

## 4. Permissions
- `administer mediaflow` (restricted) — the settings form and the credential keys.
- `use mediaflow` (restricted) — the file selector. It hands a short-lived Mediaflow access token to the user's browser, allows downloading files from Mediaflow onto the server, and allows creating media entities, and the selector loads JS/CSS from `mfstatic.com`. Grant to trusted editor roles only.

## 5. CSP (optional)
With the Content-Security-Policy module enabled, `mediaflow.csp_subscriber` automatically
whitelists Mediaflow resource hosts.
