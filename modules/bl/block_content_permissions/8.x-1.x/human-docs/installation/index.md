# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). This is a
  Drupal 10 contrib module with no Drupal 11 release.
- Core's **Block content** module (`block_content`) — the custom block library —
  must be enabled; Drupal treats it as a dependency.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_content_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_content_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_content_permissions -y
```

There is no configuration form. Once enabled, go to **People → Permissions** and
grant the new per-type permissions to your roles instead of *Administer blocks* —
see [How to use it](../index.md#how-to-use-it).
