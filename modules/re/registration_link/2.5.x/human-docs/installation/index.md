# Installation

## Requirements

Registration Link is tiny and has no third‑party requirements:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core only — there are no contrib or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/registration_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/registration_link -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en registration_link -y
```

That is all it takes. Log out (or open a private window) and the **Register** link appears in
the account menu — provided your site allows self‑registration. There is no configuration
step and no submodules.
