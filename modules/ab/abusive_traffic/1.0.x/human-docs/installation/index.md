# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Access to your server's **Apache access-log files** — the module reads these to
  find abusive IPs, so PHP must be able to read the log path on your hosting.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/abusive_traffic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/abusive_traffic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en abusive_traffic -y
```

Once enabled, configure it to point at your Apache log files. Because the tool
reads server logs containing IP addresses and requested URLs, make sure only
trusted administrators can reach it.
