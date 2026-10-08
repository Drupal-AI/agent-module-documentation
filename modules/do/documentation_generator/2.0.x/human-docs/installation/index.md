# Installation

## Requirements

Documentation generator is light on requirements:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- No third‑party Composer packages and no PHP library requirements beyond a
  supported Drupal core.

The module provides its own permission, which you will grant after enabling it.

## Install with Composer

From the project root:

```bash
composer require drupal/documentation_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/documentation_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en documentation_generator -y
```

## Grant the permission

Because the generated documentation reveals the site's structure and
configuration, the module ships its own permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant the documentation
generator permission to the administrator role only — do not extend it to
untrusted roles, and never expose the generated files publicly.

## Verify it worked

Log in as an administrator, open the module's generation page from the admin
menu, and generate the documentation. You should see a combined reference of the
site's content types, fields and enabled modules, with the option to export it to
a Word or PDF file.
