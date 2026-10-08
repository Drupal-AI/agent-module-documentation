# Google Cloud Storage File System — manual setup guide

**Google Cloud Storage File System** (`gcsfs`) provides a **stream wrapper** so
that Drupal files can be stored in and served from a **Google Cloud Storage**
bucket instead of (or alongside) the local filesystem. Managed files, images, and
their derivatives can live in GCS — which is useful for scalable, offloaded
storage and for multi‑instance deployments where the local disk isn't shared.

Unlike the experimental `gcs` module, this one adds an *additional* file system as
a stream wrapper, and it ships with Drush commands and its own permissions. You
configure the bucket and Google credentials on its settings page.

Because it authenticates to Google Cloud with a **service‑account credential**,
credential handling is the security‑critical part: store the credential as a
secret, scope it least‑privilege to the bucket, and set the bucket's access
controls to match your file‑privacy needs (private files must not be
world‑readable in the bucket).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the bucket and credentials, and
   secure them.

## Where it lives in the admin menu

The settings form is provided by the `gcsfs.config` route. Access is gated by the
module's own permission.
