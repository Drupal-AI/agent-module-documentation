# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Core's **Node** module (enabled on any standard site).
- **Views** is optional — enable it if you want to use the provided "Linked
  Content" view.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/backlinks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/backlinks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en backlinks -y
```

After enabling, head to [Configuration](../configuration/index.md) to add the
`linked_node` and `linked_url` fields, choose which fields are scanned for
links, and run the initial bulk rebuild.
