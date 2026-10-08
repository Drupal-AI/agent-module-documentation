# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`; declared
  compatible through Drupal 12).
- No other Drupal module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/database_ssl_check -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/database_ssl_check -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en database_ssl_check -y
```

There is nothing to configure — the module adds its checks to the Status Report as
soon as it is enabled.

## Verify it worked

Log in as an administrator and open **Reports → Status report**
(`/admin/reports/status`). You should see new entries describing your database
connection: whether it is using SSL/TLS, the cipher (if any), and the client
library version. Reading those entries is the whole point of the module — if they
show the connection is unencrypted and your database is remote, that is your cue to
enable SSL/TLS on the connection.
