# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No module dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/better_permissions_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_permissions_page -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_permissions_page -y
```

That is the entire setup. There is no configuration step. Visit **People →
Permissions** (`/admin/people/permissions`) and you will see the new **Permission
provider** select at the top of the page — pick a module to manage just its
permissions. See the [overview](../index.md#how-to-use-it) for the day-to-day flow.

## Verify it worked

Log in as an administrator and open `/admin/people/permissions`. Instead of the
full permissions table loading at once, you should see a **Permission provider**
select; choosing a module loads only that module's permission rows. If the page
now loads quickly on a site that previously hung, the module is doing its job.
