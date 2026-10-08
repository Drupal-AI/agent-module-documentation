<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cocoon Media Management

Connects Drupal to the Cocoon Media Management DAM (use-cocoon.nl) via its SOAP API, letting editors browse Cocoon sets/tags and import assets as Drupal media.

- Adds a media source/browser for a hosted Cocoon DAM account.
- Editors search by tag or set and import selected files into the media library.
- Authenticates to Cocoon with a subdomain, username and secret key (SHA1-hashed request auth).
- Centralises brand assets in Cocoon while surfacing them inside Drupal's media UI.

---

## Installation & configuration

- Requires the PHP SOAP extension and the core `media` module (>= 8.4).
- Enable with `drush en cocoon_media`; configure at `/admin/config/media/cocoon_media_settings`.
- Configuration permission: `administer cocoon media configuration`.
- Enter your Cocoon subdomain, username and API secret key.
- Importing requires the `add cocoon media items` permission.

---

## Usage & API

- `CocoonController` wraps the Cocoon SOAP client (`https://{subdomain}.use-cocoon.nl/webservice/wsdl`).
- Auth uses a SOAP header with `sha1(subdomain + username + requestId + secretkey)` over HTTPS.
- Methods include `getTags`, `getSets`, `getFilesByTag`, `getFilesBySet`, `getFile`, `getThumbInfo`, `getThumbTypes`, `getVersion`.
- The add-media form lives at `/media/add/cocoon_media_add` (permission `add cocoon media items`).
- A tag autocomplete route `/cocoon_media/tag_autocomplete/{tag_name}` returns JSON tag suggestions.
- The tag autocomplete route is declared `_access: 'TRUE'` (open to anonymous users).
- `CMMController::getTagsAutocomplete()` filters cached tag names by a request-supplied prefix.
- Cocoon results (sets/tags) are cached (some permanently) to reduce SOAP round-trips.
- SOAP calls run with default TLS verification (no `verify => false`).
- Thumbnails and originals are served from the Cocoon subdomain URL.
- Imported items become standard Drupal media entities in the library.
- Useful for organisations already standardised on the Cocoon DAM.
- Requires a valid Cocoon subscription and credentials to function.
- The API secret key is stored in module configuration; treat exported config as sensitive.
- If SOAP is missing or credentials are wrong, errors are logged and surfaced to admins.
- Provides admin menu, action and task links for the media integration.
