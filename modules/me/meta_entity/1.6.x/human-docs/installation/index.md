# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Dynamic Entity Reference](https://www.drupal.org/project/dynamic_entity_reference)
  module (`dynamic_entity_reference`), version `^2 || ^3 || ^4` — this is what lets a
  single meta entity type reference several different content entity types.

There are no external PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/meta_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Dynamic Entity
Reference and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meta_entity -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meta_entity -y
```

Drupal enables the `dynamic_entity_reference` dependency automatically if it is
present.

## Verify it worked

Visit **Structure → Meta entity** (`/admin/structure/meta-entity`) as a user with the
**Administer meta entity** permission. If the meta entity type listing loads, the
module is installed. From there — or, more commonly, from code — define a meta entity
type, add fields to it, and start linking metadata to your content, as described in the
main guide's "How to use it".
