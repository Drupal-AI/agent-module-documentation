<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Firebase PHP wraps the Firebase Admin SDK for PHP and exposes it as a Drupal service, so other modules can use Firebase (messaging, auth, Firestore) from Drupal.

---

Firebase PHP integrates the Firebase Admin SDK for PHP (the `kreait/firebase-php` library) and
exposes it as a Drupal service. It does not add end-user features by itself; rather, it provides a
configured Firebase client that other modules or custom code can inject to use Firebase capabilities —
Cloud Messaging (push notifications), Authentication, Firestore, Realtime Database — from within
Drupal. It is configured at `firebase_php.config`, where the Firebase service-account credentials are
provided.

Use it as the foundation for any Firebase integration on the site. The key security concern is the
service-account credential: it is a highly privileged key (the Admin SDK bypasses Firebase security
rules), so store it as a secret (environment/Key), never commit it, and restrict which code can use
the service. It is an integration/service-provider module; what it can do depends on the Firebase
project's configuration and the credential's scope.

---

- Expose the Firebase Admin SDK as a Drupal service.
- Wrap the kreait/firebase-php library.
- Let modules use Firebase from Drupal.
- Send Firebase Cloud Messaging push.
- Use Firebase Authentication.
- Access Firestore or Realtime Database.
- Configure Firebase at firebase_php.config.
- Provide the service-account credential.
- Store the credential as a secret.
- Never commit the Firebase key.
- Inject the Firebase client into code.
- Provide a configured Firebase client.
- Restrict which code uses the service.
- Understand the Admin SDK bypasses security rules.
- Serve as a Firebase integration foundation.
- Enable push notifications via Firebase.
- Scope the credential minimally.
- Depend on Firebase project config.
- Add Firebase capabilities to Drupal.
- Handle Firebase credentials securely.
