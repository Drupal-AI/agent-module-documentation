# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core **File**, **Media** and **Views** modules.
- The contributed **Views Bulk Operations** module
  (`views_bulk_operations:views_bulk_operations`) — Composer pulls this in
  automatically with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/accessible_file_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies (including Views Bulk Operations) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/accessible_file_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en accessible_file_manager -y
```

## Grant the permissions

Every screen is permission-gated, so after enabling the module go to **People →
Permissions** (`/admin/people/permissions`) and grant the relevant permissions to
your trusted administrator roles:

- **Access accessible file manager**
- **Access files overview**
- **View managed file download counts**
- **Administer site configuration** (for the administrative pieces)

Keep these restricted — the file manager exposes your whole file inventory and its
usage. There is no anonymous access to any of it.
