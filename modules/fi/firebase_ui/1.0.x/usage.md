<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Firebase UI provides a UI for sending and scheduling Firebase push notifications.

---

Firebase UI provides an **admin UI for sending and scheduling Firebase Cloud Messaging (FCM) push
notifications** — composing messages and scheduling their delivery to registered devices via Firebase. It is
in the Notifications package.

Use it to send/schedule push notifications from Firebase. It is a notifications/integration feature. Security
handling: it uses **Firebase credentials/server key** to send messages — store those as **secrets** (env/Key,
not committed config), use HTTPS, and gate the sending UI to trusted staff (sending push is a broadcast
capability). It has no access-control role beyond its admin gating. Configure the Firebase credentials and
compose notifications.

---

- Send Firebase push notifications.
- Schedule push delivery.
- Compose messages in a UI.
- Use Firebase credentials/server key.
- Store credentials as secrets.
- Use HTTPS.
- Gate the sending UI to trusted staff.
- Treat sending as a broadcast capability.
- Have no access-control role beyond gating.
- Configure Firebase credentials.
- Handle push notifications.
- Send notifications.
- Schedule notifications.
- Configure Firebase.
- Compose pushes.
- Handle the UI.
- Broadcast messages.
- Secure the server key.
- Configure notifications.
- Provide push sending.
