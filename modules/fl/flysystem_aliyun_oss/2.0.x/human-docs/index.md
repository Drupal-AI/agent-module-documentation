# Flysystem Aliyun OSS — manual setup guide

**Flysystem Aliyun OSS** (`flysystem_aliyun_oss`) lets Drupal store and serve
its managed files on an **Alibaba Cloud (Aliyun) Object Storage Service (OSS)**
bucket instead of the local disk. It plugs into the
[Flysystem](https://www.drupal.org/project/flysystem) module and registers a new
stream-wrapper scheme (for example `oss://`) that behaves just like Drupal's
built-in `public://` and `private://` schemes — image styles, file and image
fields, and Media all keep working, but the bytes live in your OSS bucket.

Choosing OSS is usually a scaling or cost decision: you keep large media out of
your server's filesystem, serve it through Aliyun's CDN, and let several web
nodes share one authoritative copy of the files. Public objects are served by
their OSS URL (optionally through a CNAME/CDN domain); private objects are served
through time-limited **signed URLs**. The module also ships several field
formatters (image, file link, audio, video, table, RSS enclosure, plain URL) for
rendering OSS-hosted files.

There is **no settings form** in the Drupal admin UI. All configuration lives in
your site's `settings.php`, where you define the scheme and its credentials. That
also means your OSS access key and secret are handled as deployment secrets —
never commit them to version control (see Installation for how to keep them safe).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Aliyun OSS SDK, and define the storage scheme in `settings.php`.

There is **no configuration page** for this module — it has no settings form.
Everything is set up in `settings.php`, described in Installation and in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Once a scheme is defined in
`settings.php`, you can pick it as the download destination on a file or image
field's storage settings, or make it the site-wide default at **Configuration →
Media → File system** (`/admin/config/media/file-system`). The health of the
scheme shows up on the Flysystem report at
**Reports → Flysystem** if the Flysystem UI is available.

## How to use it

Configuration happens entirely in `settings.php`. You add an entry to the
Flysystem schemes array describing your OSS bucket, then (optionally) make it the
default file scheme:

```php
$schemes = [
  'oss' => [
    'driver' => 'aliyun_oss',
    'name' => 'Aliyun OSS',
    'description' => 'An Aliyun OSS plugin for Flysystem',
    'cache' => FALSE,
    'config' => [
      'access_key_id' => getenv('ALIYUN_OSS_KEY_ID'),
      'access_key_secret' => getenv('ALIYUN_OSS_KEY_SECRET'),
      'endpoint' => 'oss-cn-shanghai.aliyuncs.com',
      'bucket' => 'BUCKET_NAME',
      'cname' => 'cdn.example.com',
      // Use 'public' if the bucket ACL is "public-read"; otherwise 'private'.
      'visibility' => 'private',
      // IMPORTANT: this defaults to FALSE — set it TRUE for TLS transfers.
      'use_https' => TRUE,
      'expire' => 3600,
      'timeout' => 3600,
      'connect_timeout' => 60,
    ],
  ],
];
$settings['flysystem'] = $schemes;

// Optionally make OSS the default scheme for new uploads:
$config['system.file']['default_scheme'] = 'oss';
```

A few field-by-field notes:

- **`access_key_id` / `access_key_secret`** — your Aliyun RAM credentials. Read
  them from environment variables (as shown), not as literal strings, so the
  secret never lands in a committed file.
- **`endpoint`** — the OSS region endpoint for your bucket, e.g.
  `oss-cn-shanghai.aliyuncs.com`.
- **`bucket`** — the target bucket name.
- **`cname`** — an optional custom/CDN domain that maps to the bucket, used when
  building public URLs.
- **`visibility`** — `public` serves objects by their direct URL; `private`
  serves them through time-limited signed URLs. Match this to the bucket ACL.
- **`use_https`** — **defaults to `FALSE`.** Set it to `TRUE` explicitly so
  transfers and generated URLs use TLS.
- **`expire`** — how long (in seconds) a signed private URL stays valid.

After editing `settings.php`, rebuild caches (`drush cr`) and test an upload.
