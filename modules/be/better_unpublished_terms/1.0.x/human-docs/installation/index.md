# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Taxonomy** module (`taxonomy`).
- The **Inline Entity Form** module (`inline_entity_form`), a contributed
  dependency Composer pulls in for you.

This is a **beta** release (1.0.0-beta2); test it against your term displays
before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/better_unpublished_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Inline
Entity Form dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/better_unpublished_terms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_unpublished_terms -y
```

Drupal enables Taxonomy and Inline Entity Form automatically as dependencies.
The improved unpublished-term handling applies immediately — there is no
required configuration.
