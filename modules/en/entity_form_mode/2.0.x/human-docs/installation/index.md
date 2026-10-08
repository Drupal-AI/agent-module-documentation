# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, and no PHP or third-party library requirements — the
  project notes "No requirements."

## Install with Composer

From the project root:

```bash
composer require drupal/entity_form_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_form_mode -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_form_mode -y
```

## Verify it worked

There's no admin settings page. To confirm it's doing its job, follow the
workflow in the parent [guide](../index.md): create a form mode whose machine name
matches an entity's form route (for example `node.edit_form`), enable it on a
content type's **Manage form display**, and confirm that editing that content type
now uses your custom form.
