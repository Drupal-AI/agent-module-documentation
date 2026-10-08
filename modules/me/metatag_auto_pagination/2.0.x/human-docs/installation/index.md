# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Metatag** module (`metatag`) — required. Drupal will enable it as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_auto_pagination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Metatag if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_auto_pagination -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_auto_pagination -y
```

## Verify it worked

After enabling, switch on the **AUTO PAGER LINKS** service in the Metatag basic
configuration (see the module's [overview](../index.md)). Then load a paginated
listing that is on page 2 or later and view the page source — the document head
should contain `rel="prev"` and `rel="next"` link tags. The prev link is omitted on
the first page and the next link on the last.
