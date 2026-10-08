# Firebase UI — manual setup guide

**Firebase UI** (`firebase_ui`) brings Firebase Cloud Messaging (FCM) push
notifications into the Drupal admin. Instead of writing code, administrators get a
backend UI for composing, sending, scheduling, and managing push notifications to
your site's users — all active users, specific users, or whole roles — with either
immediate or scheduled delivery.

Notifications are delivered through a **queue** so large sends scale gracefully:
Drupal cron processes the queue automatically, or you can run it on demand with
Drush. The module also manages the device tokens it needs on the user entity (a
`field_firebase_tokens` field), cleans up invalid tokens, and lets you pause,
resume, and resend notifications from a management screen. It is compatible with the
Firebase Web SDK (`firebase.messaging()`).

Sending push notifications is a broadcast capability, and it relies on your
**Firebase project credentials**. Store those credentials as secrets rather than
committing them, serve the site over HTTPS, and limit the sending UI to trusted
staff. See [Configuration](configuration/index.md) for entering the credentials and
[Installation](installation/index.md) for the required PHP libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its required PHP
   libraries with Composer, and enable it.
2. [Configuration](configuration/index.md) — enter your Firebase credentials, then
   send, schedule, and manage notifications.

## Where it lives in the admin menu

Firebase UI lives under **Configuration → Web services → Firebase UI**:

- **Settings / credentials:** `/admin/config/services/firebase-ui/settings`
- **Send a notification:** `/admin/config/services/firebase-ui/send`
- **Manage notifications:** `/admin/config/services/firebase-ui/list`
