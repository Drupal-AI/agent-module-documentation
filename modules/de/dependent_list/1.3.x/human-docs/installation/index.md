# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** (`options`) and **Field UI** (`field_ui`) modules — Drupal
  enables both automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dependent_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dependent_list -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dependent_list -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and edit an
existing list field. If installation succeeded, the field's settings now include a
**Dependent list configuration** section where you can choose a dependency field.
See the [main guide](../index.md) for how to wire two fields together.
