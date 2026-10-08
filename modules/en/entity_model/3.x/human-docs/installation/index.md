# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No module dependencies, and no third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_model -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_model -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_model -y
```

## Verify it worked

Run the module's Drush command to list model mappings:

```bash
drush entity_model:list
```

On a fresh install with no models defined yet it will simply report that models are
not mapped. Once you add an annotated `@Model` class in a custom module and rebuild
caches, running it again should show your model mapped to its class — for example
`Model "node.page" is mapped against "Drupal\mymodule\Entity\Node\Page".`
