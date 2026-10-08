# Installation

## Requirements

- **Drupal 10.2 or newer, or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **Field** module (`field`), part of a standard Drupal install and
  enabled automatically as a dependency.

There are no external Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/exclusive_boolean -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exclusive_boolean -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exclusive_boolean -y
```

## Verify it worked

Open a boolean field's settings under **Structure → Content types → *(a type)* →
Manage fields → *(a boolean field)***. You should see a new **Exclusive** option.
Turn it on, then tick the box on two different nodes of that type in turn — after
saving the second one, check the first: its box should now be unchecked
automatically. See the "How to use it" section of the [overview](../index.md) for
the full workflow.
