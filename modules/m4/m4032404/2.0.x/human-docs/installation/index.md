# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No module dependencies and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/m4032404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/m4032404 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en m4032404 -y
```

As soon as it is enabled, 403 responses across the whole site are converted to 404
(that is the default scope). If you want to narrow that down, or exempt trusted
users, configure it next.

## Grant permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant, as needed:

- **Access 403 page** (`access 403 page`) — users with this permission bypass the
  redirect and see the real 403. Useful for editors and for debugging access
  issues.
- **Administer 403 to 404 settings** (`administer 403 to 404 settings`) — gates the
  settings form. Give to administrators only.

## Next step

See [Configuration](../configuration/index.md) to scope the behaviour to admin
routes or a set of paths.
