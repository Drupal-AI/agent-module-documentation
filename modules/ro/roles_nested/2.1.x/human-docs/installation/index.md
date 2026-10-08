# Installation

## Requirements

Roles Nested is lightweight and has no third‑party requirements:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules, Composer packages, or PHP libraries are needed — it builds
  on Drupal core's own roles system.

## Install with Composer

From the project root:

```bash
composer require drupal/roles_nested -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/roles_nested -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en roles_nested -y
```

## Verify it worked

Log in as an administrator and go to **People → Roles Nested**
(`/admin/people/roles-nested`). You should see your site's roles listed with drag
handles, ready to be arranged into a hierarchy. If the page loads, the module is
installed correctly.
