# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Text** module (`text`) — enabled automatically as a dependency.

No contributed modules or external libraries are required.

> **Note:** This project is marked *minimally maintained* and its security
> advisory coverage is *not covered* by the Drupal Security Team. It is a
> developer utility — weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/email_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_messages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_messages -y
```

## Verify it worked

Because this is a developer utility with no standalone UI, confirm it is enabled
with `drush pm:list --status=enabled | grep email_messages` (or check **Extend**
in the admin UI). You then use it from your own code, as described in the
[main guide](../index.md).
