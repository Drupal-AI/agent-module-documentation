# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.
- The **Linky** module (`linky`) — Linky Replacer converts content links into
  Linky entities, so Linky must be installed and set up first.
- Optional: the **Entity Usage** module — when enabled, the created Linky entities
  carry usage metadata so you can see where each link is used.

## Install with Composer

From the project root:

```bash
composer require drupal/linkyreplacer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkyreplacer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkyreplacer -y
```

Make sure **Linky** is enabled as well (`drush en linky -y`) if it isn't already.

## Grant the permission

Go to **People → Permissions** and grant Linky Replacer's permission to the
trusted roles that should be able to run the link conversion.

## Verify it worked

With Linky in place, run the replacement against content that contains external
links, then confirm those raw URLs have been converted into references to Linky
entities and that the corresponding Linky (Managed Link) entities now exist. If
Entity Usage is enabled, check that the created links show usage information.
