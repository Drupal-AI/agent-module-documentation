# Installation

## Requirements

Static Node Generator needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.0 or higher** recommended.
- Core's **Node** (`node`) and **File** (`file`) modules — both are standard on a
  Drupal install.

No third-party libraries are required. Drush is optional but handy for bulk
generation from the command line.

## Install with Composer

From the project root:

```bash
composer require drupal/static_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_node -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en static_node -y
```

## After installing

1. Grant the **generate static node** and **delete static node** permissions at
   `/admin/people/permissions` to the roles that should manage static pages.
2. Visit `/admin/config/system/static-node` to choose which node types support
   static generation and to set the static files folder (default
   `public://static`).
3. Manage the files you generate at `/admin/content/static-files`.

See [Configuration](../configuration/index.md) for the details.
