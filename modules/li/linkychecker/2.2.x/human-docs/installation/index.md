# Installation

## Requirements

- **Drupal 10 or newer** (the 2.2 branch requires Drupal 10 as a minimum).
- **PHP 8.1** or newer.
- The **Linky** module (`linky`) — Linkychecker checks Linky's Managed Link
  entities, so install and enable Linky first.

## Install with Composer

From the project root:

```bash
composer require drupal/linkychecker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkychecker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkychecker -y
```

## Grant permissions

Go to **People → Permissions** and grant Linkychecker's permissions to the roles
that should be able to configure checking and view results (typically
administrators and editors).

## Verify it worked

Create or open a Linky (Managed Link) entity — by default it is checked on
creation. Confirm a status is recorded for the link, then try an on-demand check
or run the module's Drush command to check links from the command line. See
[Configuration](../configuration/index.md) for the details.
