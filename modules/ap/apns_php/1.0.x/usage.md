<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
APNs PHP exposes the edamov/pushok library as a Drupal service for sending Apple Push Notifications, with a settings form and a test-message form.
---
`ApnsPhpMessagingService`/`ApnsPhpMessagingApi` build a pushok client from configuration — Apple key ID, team ID, app bundle ID, a token/certificate file path, an optional passphrase, and sandbox/production toggle — and send notifications, including a custom payload key carrying a deep-link URL that the app reads as `notification.data.<key>`. Typed exceptions cover auth, missing certificate, invalid token, payload and server errors, and a logging level controls how much is written to Drupal logs.

Configure at `/admin/config/system/apns_php` (`administer site configuration`): the certificate PATH is stored (the form explicitly warns it must live OUTSIDE the webroot, and supports absolute, relative or `private://` stream-wrapper paths), and a test-message form lets you verify delivery. SECURITY OBSERVATION: the certificate passphrase (`certificate_secret`) is stored in plaintext in the `apns_php.settings` config object (a `string` in `config/schema/apns_php.schema.yml`); the `.p8`/`.pem` key material itself is kept on disk by path (recommended outside webroot), not in config. There are no anonymous or mutating public endpoints.
---
- Send an Apple Push Notification from Drupal code.
- Wrap edamov/pushok as an injectable service.
- Configure the Apple key ID, team ID and bundle ID.
- Point the module at a `.p8`/`.pem` certificate path.
- Store the certificate outside the webroot (recommended).
- Use a `private://` stream-wrapper path for the certificate.
- Set an optional certificate passphrase.
- Toggle between the sandbox and production APNs environment.
- Send a deep-link URL in a custom payload key.
- Change the payload key (e.g. `url`, `link`, `deeplink`) — not `aps`.
- Send a test message from the admin form.
- Validate a device token before sending.
- Log token-validation results to the database (optional).
- Choose the logging verbosity level.
- Handle auth failures via a typed exception.
- Handle an invalid device token via a typed exception.
- Handle payload/server errors distinctly.
- Integrate push into a decoupled mobile-app backend.
- Restrict configuration to site administrators.
- Keep key material on disk rather than in config.