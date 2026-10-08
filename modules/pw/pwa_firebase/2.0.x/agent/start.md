<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PWA Firebase — agent index

**Firebase Cloud Messaging (FCM) web-push** for a Drupal PWA (serves `manifest.json` + `firebase-messaging-
sw.js`, registers push tokens, admin compose/send). Config at `pwa_firebase.configuration`; provides
permissions. Version **2.0.11**. Core `^9||^10||^11`.

Push tokens are registered via `/firebase-send-token` (`tokenReceived()`, POST `token`/`action`;
`action=delete` removes a token). Public manifest/SW/offline routes are expected. Store Firebase creds as
secrets.
