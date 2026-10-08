# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contrib module dependencies — it needs only Drupal core.
- A search form to style: the core **Search** block (from core's Search module) is
  the usual target. Make sure that block is placed in a region so there is something
  to restyle.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_search -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_search -y
```

The module starts styling the core search block immediately with its default
options (the "Background Fade" animation, a "search" placeholder, and a hidden
submit button). To change any of that, see
[Configuration](../configuration/index.md).

## Grant the settings permission

Access to the settings form is controlled by the **Administer Better Search
settings** permission. Grant it to the appropriate role at **People → Permissions**
(`/admin/people/permissions`) if the person tuning the search block isn't a full
administrator.
