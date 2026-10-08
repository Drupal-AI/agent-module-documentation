<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Override the filesystem to use Google Cloud Storage for all file schemes.

---

GCS overrides the filesystem to use Google Cloud Storage instead of local storage for all file schemas (`public://`, `private://`, etc.) — so uploaded/managed files live in a GCS bucket rather than on the Drupal server, useful for scalable/containerised hosting.

The GCS service-account credentials must be stored securely (env-backed / a mounted key), never committed, and the bucket ACLs scoped so `private://` files aren't world-readable. Supports Drupal 11 and 12.

---

- Store files in Google Cloud Storage.
- Override the filesystem.
- Cover public:// and private://.
- Move files off the server.
- Support scalable/containerised hosting.
- Store credentials securely.
- Scope bucket ACLs (protect private).
- Never commit credentials.
- Support Drupal 11 and 12.
- Configure the bucket.
- Aid cloud hosting.
- Handle GCS files
- Support Drupal.
- Support Drupal.
- Support Drupal.
