# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **File** module enabled — this is the only dependency, and it's on by
  default on most sites.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_linktext_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/file_linktext_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_linktext_formatter -y
```

That's all. There is no settings form and no permissions to grant. To start using
it, go to a bundle's **Manage display** tab and pick the **"Link text from
field"** format on a single‑value File field — see [the main
page](../index.md#how-to-use-it) for the step‑by‑step.
