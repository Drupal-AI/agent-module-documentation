# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (the module alters the taxonomy vocabulary form).

There are no other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/vocabulary_description_length -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/vocabulary_description_length -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vocabulary_description_length -y
```

That's all. There is no configuration — open any vocabulary's add or edit form
(**Structure → Taxonomy**) and the **Description** field is now a multi-line box.
