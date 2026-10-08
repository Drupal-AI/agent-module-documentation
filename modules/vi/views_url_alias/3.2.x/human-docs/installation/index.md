# Installation

## Requirements

Views URL alias builds entirely on Drupal core, but it needs these core modules
enabled (Drupal turns them on for you as dependencies):

- **Views** (`views`)
- **Path** (`path`)
- **Path alias** (`path_alias`)

It runs on **Drupal 8.8 through 11** (`core_version_requirement: ^8.8 || ^9 || ^10
|| ^11`) and has no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_url_alias -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_url_alias -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_url_alias -y
```

On install, the module creates its `views_url_alias` mapping table. If your site
already has path aliases, it flags that the table needs an initial rebuild and shows
a warning to users with the *Administer views* permission — follow the
[rebuild steps](../index.md#rebuild-the-alias-index) once to populate the table.

There is no settings form to fill in. From here you work entirely in the Views UI —
see [How to use it](../index.md#how-to-use-it).
