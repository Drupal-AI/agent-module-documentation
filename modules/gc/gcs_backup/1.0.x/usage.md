<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GCS Backup uploads backups to a Google Cloud Storage bucket with retention.

---

GCS Backup creates site backups and stores them on Google Cloud Storage (GCS) with a configurable retention policy — uploading backup archives to a configured bucket and pruning old ones. Backups are staged in the private filesystem (`private://gcs_backups/`) before upload and on restore.

GCS credentials/bucket are configured in admin settings and should be stored securely (env-backed); the private staging directory keeps archives out of the web root. Administration is via `/admin/config/system/gcs-backup`. Supports Drupal 10 and 11.

---

- Back up the site to Google Cloud Storage.
- Apply a retention policy.
- Upload archives to a GCS bucket.
- Prune old backups.
- Stage backups in `private://`.
- Keep archives out of the web root.
- Store GCS credentials securely.
- Keep credentials env-backed.
- Administer via /admin/config/system/gcs-backup.
- Support Drupal 10 and 11.
- Restore from the bucket.
- Configure the bucket name.
- Manage backup lifecycle.
- Support disaster recovery.
- Automate backups.
- Secure backup storage.
- Retain recent backups.
- Handle backup files privately.
