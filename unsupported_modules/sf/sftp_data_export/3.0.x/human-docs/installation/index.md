# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The PHP **`ssh2` extension** must be installed and enabled — the module uses
  `ssh2_connect`, `ssh2_auth_password` and `ssh2_sftp` to talk to the remote server.
- A remote SFTP server you can write to, with its host, port, username and password.
- No other contrib modules are required.

## Install with Composer

Note the package/machine-name mismatch: the Composer package is **`sftp_export`**
even though the module is enabled as **`sftp_data_export`**.

```bash
composer require drupal/sftp_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sftp_export -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. If the `ssh2` extension isn't
> present in your container, add it before enabling the module.

## Install the SSH2 PHP extension

The module will not work without PHP's `ssh2` extension. Install it via your
system's package manager / PECL (for example `pecl install ssh2`, or your container's
equivalent) and confirm it's loaded with `php -m | grep ssh2` before continuing.

## Enable the module

```bash
drush en sftp_data_export -y
```

(Enable the machine name `sftp_data_export`, even though you required
`drupal/sftp_export`.)

## Next steps

Choose the fields to export, enter your SFTP credentials, and run the export. See
[Configuration](../configuration/index.md) — and review the security notes in the
[main guide](../index.md) first, since credentials are stored in plaintext and the
output CSV lands in a web-accessible directory.
