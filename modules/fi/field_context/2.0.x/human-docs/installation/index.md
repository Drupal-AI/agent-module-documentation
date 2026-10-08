# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** (`views`) module, which is where the plugin appears. It is
  enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_context -y
```

That is all the setup there is. Once enabled, the **Field from route context**
option becomes available when you configure a contextual filter's default value in
any view — see the "How to use it" section of the
[overview](../index.md) for the step-by-step.

There are no submodules and no configuration page.
