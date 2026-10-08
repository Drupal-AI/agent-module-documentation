# GCS — manual setup guide

**GCS** (`gcs`) overrides Drupal's filesystem so that files are stored in **Google
Cloud Storage** instead of on the local server — for *all* file schemes
(`public://`, `private://`, and so on). The idea is that uploaded and managed
files live in a GCS bucket rather than on the Drupal host, which suits scalable or
containerised hosting where local disk isn't shared between instances.

> **Important — this module is not production‑ready.** The maintainer explicitly
> states it is in active development and *not* ready for any usage yet. It
> currently works by overriding the FileSystem service and rewriting URLs, with
> known gaps (for example around stream wrappers and non‑image assets). Treat it as
> experimental. If you need a stable Google Cloud Storage integration today, look
> at the sibling **Google Cloud Storage File System** (`gcsfs`) module instead.

Because the module authenticates to Google Cloud, you must supply service‑account
credentials. Store them securely and scope your bucket carefully — see below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated admin settings form documented for this module — credentials
and the bucket are supplied through your environment (see Installation). The rest
of this section explains the credential and bucket handling you must get right.

## Credentials and bucket safety

- **Keep credentials out of the codebase.** Provide the GCS service‑account key
  through an environment variable or a mounted key file — never commit it to
  version control or place it in the web root.
- **Scope the service account** to the specific bucket with least‑privilege
  permissions.
- **Match bucket ACLs to file privacy.** Because this module routes *all* schemes
  (including `private://`) to GCS, make sure your bucket's access settings don't
  make `private://` files world‑readable.
