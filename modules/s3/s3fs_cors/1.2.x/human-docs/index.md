# S3 File System CORS Upload — manual setup guide

**S3 File System CORS Upload** (`s3fs_cors`) extends the popular
[S3 File System](https://www.drupal.org/project/s3fs) (`s3fs`) module so that files
upload **straight from the visitor's browser to your AWS S3 bucket**, instead of
travelling through your Drupal/PHP server first. For large media — video, big
images, design assets — this sidesteps PHP's memory and time limits and your web
server's `post_max_size` / `upload_max_filesize` caps, and it takes upload load off
the server entirely. After the browser finishes the upload, the module registers the
object as a normal Drupal managed file so it behaves like any other file field value.

It works by adding two field widgets — one for **file** fields and one for **image**
fields — that you assign on a field's *Manage form display*. Behind the scenes the
widget generates a short‑lived, signed "presigned POST" permission so the browser is
allowed to write directly to your bucket, and a small JavaScript layer sends the file
there. The object's location (its S3 key) is derived from the field's upload
destination, reusing your existing `s3fs` bucket, region, credentials, and folder
structure — you don't reconfigure any of that here.

The module adds one admin form for the CORS‑specific settings: which origin(s) may
upload to the bucket, whether the upload endpoint uses HTTP or HTTPS, and whether
uploaded objects are public or private. Notably, **saving that form configures the
bucket's CORS rules directly at AWS** for you, so you don't have to edit the bucket
policy by hand in the AWS console.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it builds on S3 File System).
2. [Configuration](configuration/index.md) — the CORS admin form and how to put the
   direct‑upload widgets on your fields.

## Where it lives in the admin menu

Its settings form is at **Configuration → Media → S3 File System → CORS Upload**
(`/admin/config/media/s3fs/cors`). The widgets themselves are chosen on each field's
**Manage form display**.

## How to use it

1. Get **S3 File System** fully working first (bucket, region, and credentials).
2. Install and enable this module.
3. On the **CORS Upload** admin form, set your allowed origin and ACL, and save —
   this also writes the CORS rules to your bucket.
4. On a file or image field's **Manage form display**, switch its widget to the
   *S3 CORS* variant.
5. Edit content with that field — the file now uploads directly to S3 from the
   browser.

The full walkthrough is in [Configuration](configuration/index.md).
