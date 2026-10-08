# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other modules are required — it depends only on Drupal core.
- No third‑party Composer or PHP library requirements.

This is a developer‑oriented module: it provides plumbing (a service pass and
provider) and does nothing on its own until you register tagged preprocess
services in your own code.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_preprocess_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_preprocess_services -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_preprocess_services -y
```

## Submodules

- **Entity Preprocess Services Example** (`entity_preprocess_services_example`) —
  a small example module that demonstrates a working preprocess service and its
  `*.services.yml` tagging. Enable it if you want a copy‑paste reference:

  ```bash
  drush en entity_preprocess_services_example -y
  ```

  You would typically remove it again once your own services are in place; it is
  purely illustrative.

## Verify it worked

Enabling the base module makes no visible change on its own — that is expected.
To confirm it is working, enable the example submodule (or register your own
tagged service) and view an entity of the type your service targets; the template
variables your service sets should be available in that entity's Twig template.
