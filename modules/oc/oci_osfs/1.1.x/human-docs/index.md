# OCI Object Storage File System — manual setup guide

**OCI Object Storage File System** (`oci_osfs`) lets Drupal store its files in
**Oracle Cloud Infrastructure (OCI) Object Storage** instead of on local disk. It
does this with a stream wrapper for an `oci://` scheme, built on the AWS SDK for
PHP against OCI's S3‑compatible API — so files can live in the cloud, which suits
scalable and containerised hosting where local disk isn't durable.

It is a fairly complete integration. Beyond basic read/write/delete/rename/stat
file operations, it offers metadata caching with a configurable TTL, 7‑day
**presigned URLs** for public file access, support for **image styles** (image
derivatives) via custom routing, an optional mode that **overrides `public://` and
`private://`** so existing code transparently uses OCI, and a batch **migration
tool** to copy your existing local files up to the bucket. An admin interface
handles all of it, including a "Validate configuration" action that tests the
connection.

Authentication is flexible — it can use S3‑compatible **Customer Secret Keys**
(recommended), native **OCI API keys**, or **instance principals** on OCI Compute —
and it auto‑detects the best available method. Whichever you choose, the OCI
credentials, namespace, and bucket are sensitive: **store credentials securely**
(environment‑backed, never committed), and scope the bucket's permissions so that
private files aren't accidentally world‑readable. The
[Configuration](configuration/index.md) page covers both the admin‑UI and the
`settings.php` approaches.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (the AWS SDK
   comes along automatically) and enable the module.
2. [Configuration](configuration/index.md) — connect to your bucket, choose an
   authentication method, and store credentials securely.

## Where it lives in the admin menu

Once enabled, the module adds two pages under **Configuration → Media**:

- **Settings** — `/admin/config/media/oci-osfs` — credentials, region, namespace,
  bucket, delivery method, and cache settings.
- **Actions** — `/admin/config/media/oci-osfs/actions` — *Validate Configuration*
  (test the OCI connection), *Refresh Metadata Cache*, and *Copy Local Files to
  OCI* (the batch migration tool).
