# Installation

## Requirements

Flysystem SFTP needs:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Flysystem** module (`flysystem`) enabled — the required dependency that
  provides the stream-wrapper framework.
- The **League Flysystem SFTP adapter** PHP library, which Composer pulls in as a
  dependency.
- Access to a **remote SFTP server** — its hostname, a login user, and either a
  password or an SSH private key, plus the remote root directory you want to use.

## Install with Composer

From the project root:

```bash
composer require drupal/flysystem_sftp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the League SFTP
adapter and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flysystem_sftp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flysystem_sftp -y
```

Enabling the module registers the `sftp` driver with Flysystem, but nothing is
stored remotely yet — you must define a scheme in `settings.php` first.

## Configure the scheme in settings.php

This module has no admin form; the storage scheme lives in `settings.php`. See
"How to use it" in the [guide overview](../index.md) for a complete example. In
short: add an `sftp` entry to `$settings['flysystem']` with the host, username,
credentials, and remote root.

### Keep your credentials out of version control

The SFTP password or private key is a **secret**. Do not commit it:

- Store credentials in environment variables (for DDEV:
  `ddev dotenv set .ddev/.env --sftp-password=<value>`, then `ddev restart`).
- Read them in `settings.php` with `getenv('SFTP_PASSWORD')` (or the private-key
  path variable).
- Never commit `.ddev/.env` or a private key file.

### Harden the connection

By default the adapter trusts whatever host answers the connection — it does not
enforce SSH host-key verification. Add the server's **`hostFingerprint`** to the
scheme config so Drupal verifies it is talking to the intended server.

## Verify it worked

After editing `settings.php`, rebuild caches:

```bash
drush cr
```

Then check the **Flysystem status report** — the module's `ensure()` health check
attempts a connection and reports any login or root-directory errors there. Once
it reports healthy, upload a test file to a field using the SFTP scheme and
confirm it lands in the remote root directory.
