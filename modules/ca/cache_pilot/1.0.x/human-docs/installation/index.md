# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A PHP environment with **APCu** available — that is the cache these tools manage.
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cache_pilot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cache_pilot -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cache_pilot -y
```

## Grant the permission

Cache Pilot ships its own permission controlling who may view and clear APCu. After
enabling the module, go to **People → Permissions** and grant it only to trusted
administrator roles. Because clearing APCu affects the entire PHP process — every
request, and on shared hosting every other site on that process — keep this
permission tightly restricted.
