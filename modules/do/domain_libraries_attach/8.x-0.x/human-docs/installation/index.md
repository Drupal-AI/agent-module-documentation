# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Domain** module (`domain`) — this module is built for Domain-based
  multi-sites and its settings live in the Domain admin area, so you need Domain
  installed and your domain records created.
- No separate PHP library requirements.

> **Release / coverage note:** the documented release is **8.x-0.1-alpha7** and the
> project is **not covered** by Drupal's security advisory policy. Test before
> deploying to a sensitive production site.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_libraries_attach -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install the Domain module too if it is not already present:

```bash
composer require drupal/domain -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_libraries_attach -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_libraries_attach -y
```

Make sure the Domain module is enabled and your domains are created first.

## Verify it worked

Go to **Configuration → Domain → Domain libraries settings**
(`/admin/config/domain/domain_libraries_attach`). You should see a form where you
can assign your theme's libraries to your domains. See
[Configuration](../configuration/index.md) for how to define a library and map it.
