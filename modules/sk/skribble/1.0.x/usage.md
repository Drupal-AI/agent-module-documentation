<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Skribble Integration connects a Drupal site to the skribble.com e-signature API so a file can be sent for signing and the signed PDF stored back on the site.
---
The flow is: a signing request is created from a File (or a node file field) via `ApiClient::signatureRequest()`, the user is redirected to skribble.com to sign, and on return (`/skribble/finish/{signing_request}`, or the optional skribble callback) the module re-fetches the authoritative status from Skribble and, only when `status_overall === 'SIGNED'`, downloads the signed document into `private://skribble/`. State is tracked in a custom `skribble_signing_request` entity. The document can be delivered to Skribble either as a base64-encoded upload or as a protected fetch URL — the latter uses an HMAC-signed, time-limited download route (`/skribble/download/{file}/{expire}/{hmac}`) whose key is derived from the site private key plus the hash salt.

Configuration lives at `/admin/config/services/skribble` (permission `administer site configuration`): enter the Skribble user + API key, choose base64 vs. protected-link file delivery, quality/legislation, whether to email signers, and whether to enable the success callback. The signing-request entity type is administered at `admin/structure/skribble-signing-request` with its own CRUD permissions. Every step is alterable through hooks documented in `skribble.api.php` (`hook_skribble_alter_signatures`, `_alter_redirect_url`, `_signed_document_download`, etc.). Note the public callback `/skribble/callback/success/{signing_request_uuid}` is intentionally unauthenticated but does not trust the caller: it loads the request by unguessable UUID and re-verifies status via an authenticated API call before marking anything signed.
---
- Send a document to skribble.com for electronic signature.
- Start a signing request from an uploaded File entity.
- Start a signing request from a file field on a node.
- Redirect a logged-in user to skribble.com to sign.
- Fetch and store the signed PDF into private files on return.
- Track signing state in `skribble_signing_request` entities.
- List signing requests under Admin » Content.
- Configure Skribble credentials at `/admin/config/services/skribble`.
- Choose base64 upload vs. protected fetch-URL delivery of the file.
- Serve the source file to Skribble via an HMAC-protected, expiring URL.
- Enable a success callback so Skribble notifies the site when signing completes.
- Set signature quality (e.g. SES/AES/QES) and legislation.
- Email signers a notification when a request is created.
- Alter the signatures list via `hook_skribble_alter_signatures()`.
- Change the redirect/exit URL via `hook_skribble_alter_redirect_url()`.
- Post-process the downloaded PDF via `hook_skribble_signed_document_download()`.
- Grant view/create/edit/delete permissions on signing-request entities.
- Add a signing action link to content via the provided action link.
- Customise the request title/message with the alter hooks.
- Re-check a request's status by hitting the finish route again.
- Integrate e-signing into an editorial or contract workflow.
- Store all signed documents centrally in `private://skribble/`.
