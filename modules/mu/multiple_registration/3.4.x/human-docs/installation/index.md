# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Path alias** module (`path_alias`), enabled — the module creates a
  path alias for each registration page. Drupal enables it as a dependency
  automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multiple_registration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_registration -y
```

There are no submodules.

## Verify it worked

Log in as an administrator and visit **Configuration → People → Multiple
registration pages** (`/admin/config/people/multiple_registration`). You should
see a listing of roles you can create registration pages for. Continue to
[Configuration](../configuration/index.md) to create your first page.
