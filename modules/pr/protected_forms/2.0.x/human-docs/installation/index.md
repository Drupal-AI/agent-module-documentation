# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`), including Drupal 9, 10, and
  11.
- No third-party Composer libraries and no contrib dependencies. It works with core's
  form and logging systems out of the box.

The forms it protects (comment, contact, webform, user, private message) come from
core or other modules — you only need those modules present if you actually use those
forms. Webform and Private Message support activates automatically when those modules
are installed.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_forms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/protected_forms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_forms -y
```

The module ships sensible defaults (a Latin-friendly allowed-scripts list and a
starter blocklist of spam patterns), so protection is active on the relevant forms as
soon as you enable it. You can then tune the rules and permissions — see
[Configuration](../configuration/index.md).
