# S3 File System — manual setup guide

**S3 File System** (`s3fs`) gives Drupal an additional file system that stores
uploaded files in Amazon S3 — or any S3-compatible service such as MinIO, Ceph or
DigitalOcean Spaces — instead of on the web server's local disk. It adds an
`s3://` stream wrapper backed by the AWS SDK for PHP, and it can optionally take
over Drupal's `public://` and/or `private://` schemes entirely, so that ordinary
uploads land in a bucket and are served from S3 or a CDN.

This is the module you want for sites that run behind a load balancer or on
autoscaling, ephemeral containers, where the local `sites/default/files`
directory is not shared between servers and would otherwise get out of sync. It
also lets you serve public files through CloudFront with a custom domain, keep
private files in S3 while still enforcing Drupal's access checks, encrypt objects
server-side, and generate time-limited presigned URLs.

S3 File System needs configuration before it does anything useful — you have to
point it at a bucket, give it credentials and (usually) build its metadata cache.
Two important decisions are made in `settings.php` rather than the settings form:
whether to take over the public and private file systems
(`$settings['s3fs.use_s3_for_public']` and `['s3fs.use_s3_for_private']`), and
optionally where the AWS keys come from. Everything else lives on the admin form.
Because S3 has no cheap way to `stat()` a file, the module keeps a database-backed
**metadata cache** of every object, which you refresh with a Drush command after
files change outside Drupal.

It has no other Drupal module dependencies and no submodules, but it does require
the `aws/aws-sdk-php` library (`^3.18`), pulled in by Composer. It optionally
integrates with the **Key** module so AWS keys can be stored as Key entities
instead of in `settings.php`.

This guide is written for a **human** setting the module up through the admin UI
and Drush. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the services, hooks and
architecture in a token-cheap form.

## Contents

1. [Installation](installation/index.md) — Composer, the AWS SDK, the unusually
   narrow core-version constraint, and enabling the module.
2. [Configuration](configuration/index.md) — credentials, bucket and region, the
   serving domain, taking over public/private files, object behaviour, and the
   metadata-cache Drush commands.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → S3 File System**
(`/admin/config/media/s3fs`, config route `s3fs.admin_settings`), protected by the
**Administer S3 File System** (`administer s3fs`) permission. A companion
**actions** form at `/admin/config/media/s3fs/actions` has a **Validate** button
(checks your configuration against the live bucket) and a **Refresh file metadata
cache** action.

## How to use it

With takeover **off**, S3 is available only through the explicit `s3://` scheme —
for example you can choose it as a particular file field's upload destination,
leaving everything else on local disk. With takeover **on**
(the `settings.php` switches), existing `public://` and `private://` URIs keep
working but resolve to the bucket. Because of that, the correct migration order
matters: configure and validate, copy your existing local files up with
`drush s3fs:copy-local` **while Drupal is still serving them locally**, then flip
the takeover switches, then refresh the cache. Flipping takeover before copying
leaves every existing file URL pointing at an object that does not exist yet, so
images 404 until the copy finishes. The [Configuration](configuration/index.md)
page walks through all of this.
