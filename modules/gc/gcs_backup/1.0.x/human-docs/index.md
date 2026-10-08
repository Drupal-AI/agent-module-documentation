# GCS Backup — manual setup guide

**GCS Backup** (`gcs_backup`) creates site backups and stores them on **Google
Cloud Storage**, with a configurable **retention policy** that prunes old backups
automatically. Backups are staged in Drupal's private filesystem
(`private://gcs_backups/`) before they're uploaded — and on restore — which keeps
the archives out of the web root.

You can trigger and manage backups from the command line with the module's Drush
commands, or programmatically through its `GcsBackupManager` service. The bucket
and Google Cloud credentials are set on the module's admin settings page.

Because it authenticates to Google Cloud, you'll need a service account with
Storage access. Store those credentials securely — in an environment variable, not
in committed configuration or version control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — point it at your bucket, set the
   retention policy, and secure your credentials.

## Where it lives in the admin menu

The settings form is at **Configuration → System → GCS Backup**
(`/admin/config/system/gcs-backup`).
