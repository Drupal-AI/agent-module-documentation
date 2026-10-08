# Configuration

GCS Backup is configured from one admin page where you point it at your Google
Cloud Storage bucket and set how long backups are kept.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → GCS Backup**
   (`/admin/config/system/gcs-backup`).

## The settings

- **Bucket** — the name of the Google Cloud Storage bucket where backup archives
  are uploaded.
- **Google Cloud credentials** — the service‑account credential the module uses to
  authenticate to GCS. See the security note below.
- **Retention policy** — how many backups (or how long) to keep. Older archives
  beyond the retention window are pruned automatically so the bucket doesn't grow
  without bound.

Save the form to apply your settings.

> **Keep credentials secret.** Store the Google Cloud service‑account credential
> in an environment variable rather than committing it to configuration or version
> control. With DDEV: `ddev dotenv set .ddev/.env
> --google-application-credentials=<path-or-value>` then `ddev restart`. Scope the
> service account to just the backup bucket with least‑privilege permissions.

## Running backups

Backups are staged in `private://gcs_backups/` before being uploaded — so make
sure your private filesystem is configured and kept out of the web root. You can
trigger and manage backups with the module's **Drush commands** (run `drush list`
to see them) or, for more advanced use, through the `GcsBackupManager` service in
custom code. Restores pull the archive back down from the bucket via the same
private staging directory.
