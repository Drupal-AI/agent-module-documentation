# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Domain** module (`domain`) — Domain Route Access delegates enforcement to
  Domain's `_domain` access check.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_route_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_route_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_route_access -y
```

This also enables the `domain` module if it is not already on.

## Verify it worked

Grant the **Administer domain route access** permission to your admin role
(**People → Permissions**), then go to **Configuration → Domain → Route Access**
(`/admin/config/domain/route-access`). You should see a listing with an *Add* link.
See [Configuration](../configuration/index.md) for creating a rule.
