# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) — this is the only dependency, and Drupal
  enables it automatically when you turn on Release Version.
- A way for your deploy pipeline to set an **environment variable** holding the
  version string.

## Install with Composer

From the project root:

```bash
composer require drupal/release_version -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/release_version -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en release_version -y
```

## Verify it worked

Set the environment variable the module reads (see "How to use it" in the
[overview](../index.md)), then log in as a staff user with the admin toolbar. The
current version string should appear in the toolbar. If nothing shows, confirm the
environment variable is actually set in the running web container and that the
module is pointed at the correct variable name.
