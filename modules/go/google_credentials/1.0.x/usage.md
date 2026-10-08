<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Credentials stores credentials for Google Cloud services.

---

Google Credentials provides a place to store credentials for Google Cloud — a base module where a Google Cloud service-account key/credentials are configured once and reused by other Google Cloud integration modules (Storage, Pub/Sub, etc.).

Store the service-account key securely (env-backed / a mounted key file or a Key entity), never committed. Supports Drupal 9, 10, and 11.

---

- Store Google Cloud credentials.
- Provide a shared credentials base.
- Configure a service-account key once.
- Reuse across Google modules.
- Underpin Storage/Pub-Sub etc.
- Store the key securely (env-backed).
- Never commit the key.
- Support Drupal 9, 10, and 11.
- Configure the credentials.
- Aid Google Cloud integration.
- Handle GCP credentials.
- Serve as a base module
- Secure secrets
- Support GCP
- Support Drupal.
