<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Firebase PHP — agent index

Exposes the **Firebase Admin SDK for PHP** (`kreait/firebase-php`) as a **Drupal service** for other
modules — Cloud Messaging, Auth, Firestore, Realtime DB. Config at `firebase_php.config`. Version
**8.0.0-beta3**. Core `^10||^11`.

**Security:** the Firebase **service-account credential is highly privileged (Admin SDK bypasses
security rules)** — store as a secret (env/Key), never commit, restrict which code uses the service.
