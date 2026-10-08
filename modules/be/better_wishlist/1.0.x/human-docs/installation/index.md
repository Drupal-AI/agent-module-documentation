# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The contributed **Entity API** module (`entity`), which Composer pulls in for
  you.

This version follows the **1.0.x development** branch — test it before
production use. There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_wishlist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Entity API
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/better_wishlist -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_wishlist -y
```

Drupal enables the Entity API module automatically as a dependency.

## Grant permissions

Better Wishlist defines its own permission(s). After enabling, go to **People →
Permissions** (`/admin/people/permissions`) and grant the wishlist permission
to the roles that should be able to save items. Keep each user's wishlist
visible only to its owner and to administrators, since it is personal data.
