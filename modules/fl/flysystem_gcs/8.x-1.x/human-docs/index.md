# Flysystem Google Cloud Storage — manual setup guide

**Flysystem Google Cloud Storage** (`flysystem_gcs`) lets Drupal store and serve
its managed files on a **Google Cloud Storage (GCS)** bucket instead of the local
disk. It is the adapter half of the [Flysystem](https://www.drupal.org/project/flysystem)
system: it registers GCS as a Flysystem stream wrapper, so a bucket becomes a
Drupal scheme (for example `gcs://`) that behaves just like the built-in
`public://` scheme. Image styles, file and image fields, and Media all keep
working through the usual APIs — the bytes simply live in your GCS bucket.

You can adopt GCS **wholesale as the site's default file system** or **selectively
per file/image field**, which is the safer way to start. Choosing it is usually a
scaling or portability decision: containers with ephemeral disks, several web
nodes that must not each hold their own copy of the files directory, or a policy
that user uploads live in object storage.

There is **no settings form** in the Drupal admin UI. All configuration lives in
your site's `settings.php` under Flysystem's own `$settings['flysystem']` array.
Your GCS service-account key is a real secret, so it must be kept out of the
repository and supplied through an environment variable (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, create the GCS
   bucket and service account, and define the storage scheme in `settings.php`.

There is **no configuration page** for this module — it has no settings form.
Everything is set up in `settings.php`, described in Installation and in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Once a scheme is defined in
`settings.php`, you switch to it in two places:

- **Configuration → Media → File system**
  (`/admin/config/media/file-system`) — change the default download method if you
  want GCS to be the site-wide default.
- On individual file/image fields' storage settings — change the upload
  destination for existing fields you want to move to GCS.

## How to use it

Configuration happens entirely in `settings.php`. Add an entry to the Flysystem
schemes array describing your bucket and service account:

```php
$settings['flysystem'] = [
  'cloud-storage' => [
    'driver' => 'gcs',
    'config' => [
      'bucket' => 'example',
      'keyFilePath' => getenv('GCS_KEY_FILE_PATH'),
      'projectId' => 'google-project-id',
      '_localConfig' => [
        // Optional path prefix within the bucket.
        'prefix' => 'extra-folder/another-folder/',
        // Optional CNAME to rewrite public URLs.
        'uri' => 'https://cname',
      ],
    ],
    'cache' => true, // Cache filesystem metadata.
  ],
];
```

Field-by-field notes:

- **`bucket`** — the name of your GCS bucket.
- **`keyFilePath`** — the path to the service-account JSON key file. Read the
  path from an environment variable rather than hard-coding it, and store the key
  file itself in a private, non-web-accessible directory.
- **`projectId`** — your Google Cloud project ID.
- **`_localConfig.prefix`** — optional folder prefix so all objects sit under a
  sub-path of the bucket.
- **`_localConfig.uri`** — optional CNAME/CDN domain used when building public
  URLs.
- **`cache`** — cache filesystem metadata for better performance.

After editing `settings.php`, rebuild caches (`drush cr`), then switch the
default download method and/or the upload destination of existing fields as
described above.

> **Test before you switch production.** This release is a beta with a wide core
> range; verify uploads, image derivative generation, and private-file handling
> on a copy of the site before pointing production at GCS.
