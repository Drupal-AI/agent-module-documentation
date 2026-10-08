# Flysystem SFTP — manual setup guide

**Flysystem SFTP** (`flysystem_sftp`) lets Drupal store and serve its managed
files on a **remote SFTP server** instead of the local disk. It plugs into the
[Flysystem](https://www.drupal.org/project/flysystem) module and registers an
`sftp` adapter, so an SFTP location becomes a Drupal stream-wrapper scheme (for
example `sftp://`) that behaves like the built-in `public://` or `private://`
schemes. Under the hood it is a thin wrapper around the League Flysystem SFTP
adapter — this module just supplies the adapter and passes your scheme's
configuration through to it.

Use it to offload uploads or media to external SFTP storage, to share files
between Drupal and another system over SFTP, or to back a private file scheme with
a remote server. You can define several SFTP schemes for different remote servers.

There is **no settings form** in the Drupal admin UI. All configuration lives in
your site's `settings.php` as part of the Flysystem scheme definition. Because the
scheme holds SFTP credentials (a password or a private key), those are deployment
secrets and must be kept out of version control (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and define the
   SFTP scheme in `settings.php`.

There is **no configuration page** for this module — it has no settings form.
Everything is set up in `settings.php`, described in Installation and in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Once a scheme is defined in
`settings.php`, you can select it as the download destination on a file or image
field, or as the site-wide default at **Configuration → Media → File system**
(`/admin/config/media/file-system`). The scheme runs a connection health check
(`ensure()`) that reports login/root problems on the Flysystem status report.

## How to use it

Configuration happens entirely in `settings.php`. Add an `sftp` entry to the
Flysystem schemes array describing the remote server:

```php
$settings['flysystem'] = [
  'sftp' => [
    'driver' => 'sftp',
    'config' => [
      'host' => 'sftp.example.com',
      'username' => getenv('SFTP_USERNAME'),
      // Use a password OR a private key (path or contents):
      'password' => getenv('SFTP_PASSWORD'),
      'privateKey' => getenv('SFTP_PRIVATE_KEY_PATH'),
      'root' => '/home/user/files',
      'port' => 22,
      'timeout' => 10,
      // Recommended: pin the server's host key fingerprint.
      'hostFingerprint' => 'xx:xx:xx:...',
    ],
    'cache' => TRUE,
  ],
];
```

Field-by-field notes:

- **`host`** — the SFTP server hostname.
- **`username`** — the login user; read it from an environment variable.
- **`password`** / **`privateKey`** — authenticate with either a password or an
  SSH private key (a path or the key contents). Read whichever you use from an
  environment variable, never a committed literal.
- **`root`** — the remote directory the scheme is rooted at.
- **`port`** / **`timeout`** — optional connection settings.
- **`hostFingerprint`** — **strongly recommended.** By default the adapter trusts
  whatever host answers; adding the server's host-key fingerprint here makes
  Drupal verify it is connecting to the intended server.

After editing `settings.php`, rebuild caches (`drush cr`) and check the Flysystem
status report to confirm the connection is healthy.
