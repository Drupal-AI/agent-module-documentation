<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dropbox Sign integrates the Dropbox Sign (formerly HelloSign) electronic-signature API into Drupal, exposing a service for creating/sending eSignature requests and a verified callback endpoint for processing signature events.

---

The module wraps the official `dropbox/sign` PHP SDK behind a single Drupal service (`dropbox_sign`, class `Drupal\dropbox_sign\DropboxSign`). Custom code fetches that service to build and send signature requests in either "email" mode (Dropbox Sign emails signers a link) or "embedded" mode (your site renders the signing UI via an embedded sign URL), and to reach any other SDK method through `getSignatureRequestApi()`. The API key and client ID are entered on an admin settings form (`/admin/config/system/dropbox-sign`, permission `administer dropbox sign`) and stored encrypted through the Encryption module's `EncryptionService`. A public POST-only route (`/process-dropbox-sign-callback`) receives asynchronous event notifications from Dropbox Sign; the controller decodes the event, enforces a 24-hour timestamp window, and validates the event HMAC before invoking `hook_process_dropbox_sign_callback()` so other modules can react to signed documents and other events. There are no entities, plugins, Views integration, or Drush commands — this is a thin, developer-facing API bridge. It depends on the Encryption module and the `dropbox/sign` SDK library (checked by `hook_requirements()`).

---

- Send a document out for signature by email from custom code with `\Drupal::service('dropbox_sign')->createSignatureRequest($title, $subject, $signers, $file)`.
- Create an embedded signature request (signing UI hosted on your own pages) by passing `$mode = 'embedded'` to `createSignatureRequest()`.
- Fetch the embedded signing URL for a signature id with `getSignUrl($signatureId)` to render Dropbox Sign's embedded signing widget.
- Collect signatures from multiple signers on one document by passing an `email => name` array of signers.
- Redirect a signer to a custom "thank you" / next-step URL after email-mode signing via the optional `$redirectUrl` argument.
- Include a custom message in the signature-request email with the optional `$msg` argument.
- Call any other Dropbox Sign SDK operation (e.g. cancel a request with `signatureRequestCancel()`) via `getSignatureRequestApi()`.
- Embed signature/field placeholders inside document templates using text tags such as `[sig|req|signer1]` (the module enables use/hide text tags automatically).
- CC a shared inbox or archive address on every signature request via the "CC Email Addresses" setting.
- Run the whole integration against Dropbox Sign's sandbox by enabling "Test Mode" so no live/billable requests are created while developing.
- React programmatically to signature events (signed, declined, etc.) by implementing `hook_process_dropbox_sign_callback($data)` in a custom module.
- Update Drupal content or workflow state when a document is fully signed by inspecting `$data->event->event_type` in the callback hook.
- Log or audit signature activity by handling callback events (the module itself logs each verified callback).
- Register the callback URL (`/process-dropbox-sign-callback`) in your Dropbox Sign account so status updates flow back to your site automatically.
- Validate an entered API key on save (the settings form performs a live health check against the Dropbox Sign template-list endpoint).
- Store Dropbox Sign credentials encrypted at rest by relying on the required Encryption module rather than plain config.
- Restrict who can configure the integration with the dedicated `administer dropbox sign` permission (marked restricted).
- Build a legally-binding document-signing flow (contracts, consent forms, HR paperwork) driven from Drupal entities or webforms.
- Migrate an existing HelloSign integration to the current Dropbox Sign API while keeping a similar API surface.
- Gate an action in your site (e.g. granting access or fulfilling an order) on receipt of a verified "signature_request_signed" callback.
