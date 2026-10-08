# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Domain** module (`domain`) and **Domain Access** (`domain_access`), the
  access model this module builds on.
- The **Domain Configuration** submodule (`domain_config`), which ships with the
  Domain project.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_role_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_role_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_role_access -y
```

This also enables `domain` and `domain_config` if they are not already on (and
Domain Access, on which the access model depends).

## Verify it worked

Go to **Configuration → Domain** (`/admin/config/domain`). Each domain record
should now offer a new **Roles** action link. See
[Configuration](../configuration/index.md) for mapping roles to domains.
