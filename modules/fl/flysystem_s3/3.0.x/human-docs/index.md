# Flysystem Amazon S3 — manual setup guide

**Flysystem Amazon S3** (`flysystem_s3`) lets Drupal store and serve its files on
Amazon S3 — or any S3‑compatible service such as MinIO, DigitalOcean Spaces, or
Wasabi — instead of the local disk. It plugs into the
[Flysystem](https://www.drupal.org/project/flysystem) module by providing the `s3`
storage adapter, which Flysystem then exposes as a stream wrapper (for example
`s3://`). Once set up, you can make S3 your default file storage or point individual
file/image fields at it, and Drupal reads and writes those files transparently in the
cloud.

Unlike most modules, there is **no admin settings form**. You configure S3 by
declaring one or more storage "schemes" in your site's `settings.php`, giving each the
bucket, region, and credentials. Credentials can be a static access key/secret pair —
which you should supply from an environment variable, never hard‑coded — or, better
still, an AWS IAM role, in which case you provide no keys at all and AWS handles auth
for you. You can run several schemes at once (say, one public and one private bucket),
serve files through a CDN/custom domain, prefix objects into a folder, and generate
image styles straight on S3.

The module's second feature is **direct browser‑to‑S3 uploads**. When you enable CORS
on a scheme, add matching CORS rules to the bucket, and grant a user the *Use S3 CORS
upload* permission, file uploads on those fields go straight from the visitor's
browser to S3 — bypassing PHP and the web server's upload limits, which is ideal for
large media files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AWS libraries
   with Composer, and enable it alongside Flysystem.
2. [Configuration](configuration/index.md) — declare an S3 scheme in `settings.php`,
   handle credentials safely, and optionally turn on direct CORS uploads.

## Where it lives in the admin menu

The module itself has **no configuration page** — all storage configuration happens in
`settings.php`. It does add one permission, **Use S3 CORS upload**, at **People →
Permissions** (`/admin/people/permissions`). The Flysystem module provides tooling to
inspect and verify your configured schemes.

## How to use it

After installing the module and its libraries, add an S3 scheme block to
`settings.php` (bucket, region, credentials), clear caches, and then point Drupal's
default file storage or specific fields at the resulting `s3://` stream wrapper. The
full walkthrough — including safe credential handling and direct CORS uploads — is in
[Configuration](configuration/index.md).
