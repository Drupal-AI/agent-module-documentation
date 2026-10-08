# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Update** module (`update`) — the only dependency, and the module whose
  forms this one disables.

There are no third‑party PHP or library requirements.

## Install with Composer

Fittingly, install this one with Composer. From the project root:

```bash
composer require drupal/composer_forced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/composer_forced -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en composer_forced -y
```

This enables core's Update module as a dependency if it is not already on. There
is nothing else to configure — the install/update forms are disabled immediately.

## Verify it worked

Visit **Extend → Install new module** and the **Update** actions in the admin UI:
the buttons/forms that would install or update code through the browser should now
be gone. Then check **Reports → Available updates** (`/admin/reports/updates`) and
confirm it still lists available and security releases as usual — reporting is
unaffected.
