# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core's **Field** system with an **integer** field type — no contrib
  module dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/text_to_number -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_to_number -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Note:** the module is minimally maintained (maintenance fixes only). Test it
> before relying on it in production.

## Enable the module

```bash
drush en text_to_number -y
```

## Verify it worked

Go to the **Manage form display** screen for a content type that has an integer
field. The **Text to Number** widget should now be available as a choice for that
field. Select it, save, then open the entity's create/edit form: the field should
render as a text input with a "Missing" placeholder. Enter `Missing` and save —
the stored value should be NULL rather than `0`.
