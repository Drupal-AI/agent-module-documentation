# Installation

## Requirements

- **Drupal 11.3 or Drupal 12** (`core_version_requirement: ^11.3 || ^12`). The
  2.1 line reworked its internals and dropped support for older core.
- No third‑party Composer or PHP library requirements.
- **Strongly recommended:** the [Key](https://www.drupal.org/project/key) module,
  so passwords can be stored as secrets (in an environment variable or a file
  outside the web root) instead of plain text in configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/route_basic_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/route_basic_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

To add the recommended Key module as well:

```bash
composer require drupal/key -W
```

## Enable the module

```bash
drush en route_basic_auth -y
```

If you installed Key, enable it too:

```bash
drush en key -y
```

## Permissions

The module adds a **Change the Route Basic Authentication settings** permission.
Grant it only to trusted administrators at **People → Permissions** — anyone with
it can change which routes are protected and with what credentials.

## Verify it worked

Go to **Configuration → System → Route Basic Authentication settings**. If the
settings form loads, the module is installed. Nothing is protected until you add
routes and credentials — head to [Configuration](../configuration/index.md) next.
