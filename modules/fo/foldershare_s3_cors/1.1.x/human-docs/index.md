# FolderShare S3 CORS — manual setup guide

**FolderShare S3 CORS** (`foldershare_s3_cors`) lets files managed by
[FolderShare](../../../fo/foldershare/3.1.x/human-docs/index.md) be uploaded
**directly from the browser to an Amazon S3 bucket**, bypassing the Drupal server
for the actual file transfer. By configuring CORS so the browser can send bytes
straight to S3, it removes the Drupal web server from the upload path — which is a
big win for large-file upload performance.

It is a fork of the *S3 File System CORS Upload* module, re-written to work with
the **S3 File System** module and **FolderShare** together. Use it when your
FolderShare files are (or will be) stored on S3 and you want browser-to-bucket
uploads rather than routing every upload through PHP.

Because it deals with S3, the bucket and credentials are security-sensitive:
store the S3 credentials as **environment-backed secrets** (never committed), and
scope the bucket's CORS policy tightly to your own origin(s).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the S3
   File System / Token / AWS SDK requirements, and configure your bucket and CORS.

Configuration is handled through the S3 File System module's own setup (bucket,
credentials, and CORS), so there is no separate settings page documented here —
see Installation for how the pieces fit together.

## Where it lives in the admin menu

This module has no standalone configuration page of its own. It works alongside
**S3 File System** (which holds your bucket and credentials configuration) and
**FolderShare** (which manages the files). Once S3 File System is configured with
an appropriate CORS policy and your FolderShare storage points at S3, uploads go
directly from the browser to the bucket.

## How to use it

1. Install and configure **S3 File System** with your AWS bucket and credentials.
2. Configure the bucket's **CORS policy**, scoped to your site's origin(s), so the
   browser is allowed to upload directly.
3. Set up **FolderShare** to store its files on the S3-backed storage.
4. With this module enabled, FolderShare file uploads then go directly from the
   browser to the S3 bucket.
