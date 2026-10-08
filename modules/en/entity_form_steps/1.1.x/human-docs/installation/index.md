# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Field Group** module (`field_group`) — this is a hard dependency and is how
  you define which fields belong to each step. Composer pulls it in with the `-W`
  flag below.
- No third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_form_steps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Field Group and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_form_steps -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_form_steps -y
```

This also enables `field_group` if it isn't already on.

## Verify it worked

There's no admin settings page. To confirm it's available, go to any entity type's
**Manage form display**, click **Add field group**, and check that **Form step**
appears in the group-type dropdown. Then follow the "How to use it" steps in the
parent [guide](../index.md) to build your wizard.
