# Installation

## Requirements

- **Drupal 10.2 or newer, or 11** (`core_version_requirement: >=10.2 || ^11`).
- **PHP 8.2**.
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

> **Note:** this release is an early one (version `1.0.0-alpha7`), so test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/another_entity_iterator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/another_entity_iterator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en another_entity_iterator -y
```

Once enabled, the iterator helper is available to your code. There is no settings
page to configure.
