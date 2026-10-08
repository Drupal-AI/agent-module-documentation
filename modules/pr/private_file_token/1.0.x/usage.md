Private file token grants access to Drupal private files (and private image styles) by appending a signed, time-limited authentication token to their URLs, so the file can be downloaded without the normal per-user private-file access check.

---

Once enabled the module works site-wide with no configuration UI. `hook_file_url_alter()` intercepts every generated URL that uses the `private://` stream wrapper and appends two query args: `token` (a 43-char URL-safe HMAC) and `timestamp` (the request time). The token is `Crypt::hmacBase64($path . $timestamp, $private_key . $hash_salt)` — computed over the request path (without scheme/base path) and the timestamp, keyed by the site's private key plus hash salt, so it cannot be forged or guessed by an outsider. On download, `hook_ENTITY_TYPE_access()` for the `file` entity's `download` operation runs only on the three private-file routes (`system.private_file_download`, `system.files`, `image.style_private`); if a `token`+`timestamp` pair is present and the token re-validates for the current path and has not passed `expiration_time` seconds (default 10800 = 3 hours), it returns `AccessResult::allowedIf(TRUE)`, granting the download regardless of who the requester is. The only setting is `private_file_token.settings:expiration_time` (integer seconds); there is no admin form, permission, or Drush command. The `private_file_token` service (`PrivateFileTokenGenerator`) exposes `get()` and `validate()` for custom code. Note the token is a bearer credential: it is not bound to a user or session, so anyone holding a tokenized URL can fetch the file until it expires.

---

- Let an external system or CDN fetch a private file via a plain signed URL, without a Drupal login/session.
- Embed a private image (or private image style derivative) in an HTML email that recipients can load without authenticating.
- Give a mobile/native app a short-lived download link to a private file after it renders a page.
- Share a private document link that stops working automatically after a few hours.
- Serve private-stored media in a decoupled/JSON front end where cookies aren't sent to Drupal.
- Allow a headless preview to display private images by including tokenized URLs in the payload.
- Provide time-boxed access to invoice/report PDFs stored under `private://`.
- Let a webhook consumer pull a generated private file using the URL returned in the response.
- Tighten link lifetime by lowering `expiration_time` (e.g. 300 seconds) for sensitive downloads.
- Lengthen `expiration_time` where longer-lived links are acceptable.
- Sign a private-file URL programmatically with the `private_file_token` service in custom code.
- Validate an incoming token in a custom route with `PrivateFileTokenGenerator::validate()`.
- Serve private image style derivatives (`/system/files/styles/...`) to anonymous viewers of a page that already had access.
- Deliver private files through a reverse proxy that strips Drupal session cookies.
- Add downloadable private attachments to a Views/REST export consumed by another service.
- Replace a bespoke signed-URL implementation with a maintained module.
- Allow print/export tooling (wkhtmltopdf, headless Chrome) to load private images it otherwise couldn't authenticate for.
- Grant temporary file access to a third-party integration without minting API credentials.
- Support anonymous download of a private file immediately after a form submission that produced it.
- Provide expiring links in notifications (Slack, SMS) that point at private files.
