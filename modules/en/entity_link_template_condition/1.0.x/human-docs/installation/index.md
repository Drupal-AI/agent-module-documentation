# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1** or newer.
- The **Entity Route Context** module (`entity_route_context`) — this is a hard
  dependency, because the condition uses its route helper to map the current
  route back to an entity type and link template. Composer pulls it in
  automatically when you require this module.

There are no third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_link_template_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Entity Route
Context and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_link_template_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_link_template_condition -y
```

Drupal will enable Entity Route Context at the same time if it isn't already on.

## Verify it worked

Go to **Structure → Block layout**, place or configure any block, and open its
**Visibility** tab. You should see the **Entity link template** condition
available alongside the built-in conditions such as "Pages" and "Content types".
