# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.1 or newer**.
- The **ECA** module (`drupal/eca` `^2.1 || ^3.0`) — the workflow engine this
  plugs into.
- The **Tamper** module (`drupal/tamper` `^1.0`) — the library of transformation
  plugins it exposes.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_tamper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the ECA and Tamper
modules alongside it and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_tamper -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_tamper -y
```

This enables the module together with its ECA and Tamper dependencies. You will
typically also want an ECA modeller (such as the BPMN.iO submodule that ships with
ECA) to build models visually.

Once enabled, the `eca_tamper:*` actions and `eca_tamper_condition:*` conditions
appear automatically when you build an ECA model — there is no further setup. See
the [overview](../index.md#how-to-use-it) for how to use them.
