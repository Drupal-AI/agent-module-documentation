# Configuration

Flysystem is configured in two places: the **backends** are declared in
`settings.php` (there is no admin form for them), and two **admin forms** let you
sync files between schemes and migrate existing field uploads.

## Declare a scheme in settings.php

Each backend is a *scheme* — a stream-wrapper name plus a driver and its config —
added to `$settings['flysystem']` in your site's `settings.php`:

```php
$settings['flysystem'] = [
  // The stream-wrapper name. Allowed characters: letters, numbers, + . -
  // (NO underscores).
  'myfiles' => [
    'driver' => 'local',            // the Flysystem adapter/driver id
    'config' => [
      'root'   => 'sites/default/files/flysystem', // path (relative to Drupal root for public)
      'public' => TRUE,             // serve files at browser-accessible URLs + image styles
      // 'cache' => TRUE,           // cache filesystem metadata via Drupal's cache
      // 'name' => 'My files',      // friendly label shown in the file-system UI
      // 'description' => '...',     // longer description shown in the UI
      // 'replicate' => 'backupscheme', // mirror every write to another declared scheme
    ],
  ],
];
```

After editing `settings.php`, **rebuild caches** so the stream wrapper and its
routes register:

```bash
drush cr
```

(Flysystem also re-validates schemes on cron and on cache rebuild.)

> **Scheme names:** only letters, numbers, and the characters `+`, `.`, `-` are
> allowed — **no underscores**. An invalid name is rejected at install/validation
> time.

## The built-in drivers

| `driver` | Backend | Notes |
|----------|---------|-------|
| `local` | A local directory | Writes a protective `.htaccess` into local roots; with `public: TRUE` the files are served over the web. |
| `ftp` | An FTP server | Requires the PHP `ftp` extension. Config keys include `host`, `username`, `password`, `port`, `root`, and so on. |

Contrib adapter modules add more driver ids — for example `s3v2` (from
`flysystem_s3`), `sftp`, `dropbox`, `gcs`, and others. A driver whose required PHP
extension is missing is removed from the available list, and an unknown driver
falls back to a "missing" placeholder so the site doesn't break.

## Public vs non-public schemes

- **`public: TRUE`** — Flysystem registers file-serving and image-style routes, so
  browsers can reach the files directly (and image derivatives work). Use this for
  public assets.
- **Non-public** (omit or set `public: FALSE`) — files are proxied through Drupal
  at `/_flysystem/{scheme}/{filepath}`, subject to normal file access checks. Use
  this for private/protected files.

## Pointing Drupal at a scheme

Once a scheme is registered, you can use it like any other stream wrapper:

- Set it as the **default upload destination** on **Configuration → Media → File
  system** (`/admin/config/media/file-system`), so all new uploads go there.
- Choose it as the upload destination on individual file/image fields.
- Use it from code with the normal file API, e.g.
  `\Drupal::service('file.repository')->writeData($data, 'myfiles://example.txt')`.

## Move existing files onto a scheme

Flysystem adds two admin forms under **Configuration → Media → File system →
Flysystem** (`/admin/config/media/file-system/flysystem`), both requiring the
*Administer flysystem* permission:

- **Sync** — copy every file from one scheme to another in a single operation
  (useful when introducing a new remote backend or moving to a backup).
- **Field migration** — move existing file/image *field* uploads onto a Flysystem
  scheme, updating the stored file URIs, so content already on your site starts
  using the remote store.

## Inspecting schemes

There is no config entity to `drush config:get`, but you can inspect the live
schemes:

```bash
# List the active scheme names:
drush php:eval 'print implode(",", \Drupal::service("flysystem_factory")->getSchemes());'

# Run each scheme's health check:
drush php:eval 'print var_export(\Drupal::service("flysystem_factory")->ensure(), TRUE);'
```

The Status report (`/admin/reports/status`) runs the same health check and shows
any connectivity problems per scheme.
