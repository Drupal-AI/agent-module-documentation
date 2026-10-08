# Installation

## Requirements

- **Drupal 10.2 or newer** (`core_version_requirement: >=10.2`).
- Core's **Views** module (`views`) — enabled on every standard Drupal site and
  pulled in automatically as a dependency. The shipped suggestion sources are
  backed by optional Views.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_autocomplete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_autocomplete -y
```

Three autocompletion configurations are enabled on install — for the core search
block, the content search form, and the user search form — so suggestions start
working immediately on those. There are no submodules.

## After enabling

1. Grant the **Use search autocomplete** permission to the roles (often
   *Authenticated user* or *Anonymous user*) who should get suggestions on the
   front end, and **Administer search autocomplete** to those who manage the
   configurations, at **People → Permissions**.
2. To add autocompletion to your own fields or change behaviour, visit
   **Configuration → Search and metadata → Search Autocomplete** — see
   [Configuration](../configuration/index.md).
