# APNs PHP — manual setup guide

**APNs PHP** (`apns_php`) lets Drupal send **Apple Push Notifications** to iOS
apps. It wraps the well-known `edamov/pushok` PHP library as an injectable Drupal
service, so your code can send a push notification, and it adds an admin settings
form plus a test-message form so you can configure and verify delivery without
writing any code first.

The service builds a pushok client from your configuration — Apple key ID, team
ID, app bundle ID, the path to your token/certificate file, an optional
passphrase, and a sandbox/production toggle — and sends notifications. It can carry
a deep-link URL in a custom payload key that your app reads (for example
`notification.data.url`), and it raises typed exceptions for the different failure
modes (auth, missing certificate, invalid token, payload and server errors) so
callers can handle them cleanly.

**On credentials.** Two secrets are involved. The APNs signing key — your `.p8` or
`.pem` file — is kept **on disk and referenced by path**, not stored in Drupal, and
the settings form explicitly warns that this file must live **outside the
webroot**. The optional certificate **passphrase**, however, is stored as
**plaintext in the `apns_php.settings` config object**, which means it will appear
in any config export — so treat config exports as sensitive and prefer feeding the
passphrase from the environment (see the configuration page).

Both admin routes are gated by the **Administer site configuration** permission, so
there are no anonymous or public endpoints.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the certificate
   path, the passphrase, and sending a test message.

## Where it lives in the admin menu

The settings form is at **Configuration → System → APNs PHP**
(`/admin/config/system/apns_php`), and the test-message form is at
`/admin/config/system/apns_php/test`.
