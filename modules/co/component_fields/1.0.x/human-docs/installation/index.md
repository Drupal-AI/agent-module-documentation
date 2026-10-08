# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third‑party PHP or library requirements.

Note this release is an early **alpha** (1.0.0-alpha1) and is not covered by
Drupal's security advisory policy — worth weighing before using it on production.

## Install with Composer

From the project root:

```bash
composer require drupal/component_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component_fields -y
```

## Verify it worked

Go to **Configuration** and look for the Component Fields settings at
`/admin/config/component-fields/settings`. You should see a list of content
entity types and their bundles ready to be enabled. From there, continue with
[Configuration](../configuration/index.md).
