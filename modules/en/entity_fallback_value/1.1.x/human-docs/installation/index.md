# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies and no third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_fallback_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_fallback_value -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_fallback_value -y
```

## Verify it worked

There is no admin page. Once enabled, you can define a fallback-chain plugin and
read the resolved value via its token or Twig method, as described in the parent
[guide](../index.md). The module ships with a README in its repository if you want
the full plugin-authoring reference.
