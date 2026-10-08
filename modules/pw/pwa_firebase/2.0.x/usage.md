<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PWA Firebase provides Firebase Cloud Messaging push notifications and a PWA manifest/service worker.

---

PWA Firebase adds **Firebase Cloud Messaging (FCM) web push** to a Drupal PWA — it serves a
`manifest.json` and a `firebase-messaging-sw.js` service worker, registers browser push tokens, and lets an
admin compose/send push notifications (`/admin/content/notification`). It is configured at
`pwa_firebase.configuration`, provides its own permissions.

Use it to send web-push notifications to PWA users. Browsers register their push token via
`/firebase-send-token` (`PWAController::tokenReceived()`, POST `token`/`action`), which stores a row in the
`pwa_firebase` table; `action=delete` removes that token. The public `manifest.json` / service worker /
`offline.html` routes are expected for a PWA; the service worker loads the Firebase SDK from `gstatic.com`.
Store the Firebase credentials as secrets.

---

- Send FCM web-push notifications.
- Serve a PWA manifest and service worker.
- Register browser push tokens.
- Let an admin compose/send pushes.
- Configure at pwa_firebase.configuration.
- Store Firebase credentials as secrets.
- Treat public PWA routes as expected.
- Provide its own permissions.
- Handle push notifications.
- Configure Firebase.
- Handle FCM.
- Send notifications.
- Configure the PWA.
