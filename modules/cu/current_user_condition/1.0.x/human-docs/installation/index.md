# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **User** module (`user`) — a dependency, and part of every Drupal
  install, so it's already present.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/current_user_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/current_user_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en current_user_condition -y
```

## Verify it worked

Go to **Structure → Block layout**, edit or place a block, and open its
**Visibility** tab. The condition provided by this module should appear among the
available visibility conditions.
