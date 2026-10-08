# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/notify_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notify_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notify_manager -y
```

## Grant permissions

Notify Manager provides its own permissions to separate who may manage and
dispatch notifications from ordinary users. Visit **People → Permissions**
(`/admin/people/permissions`) and grant the module's permissions to the roles
(administrators and any "specific groups") who should control notifications.

## Verify it worked

After enabling the module and granting permissions, log in as a user with those
permissions and confirm you can reach the module's notification‑management
screens. For the details of defining and dispatching notifications, follow the
project's documentation on
[drupal.org/project/notify_manager](https://www.drupal.org/project/notify_manager).
