# Installation

## Requirements

- **Drupal 10.4 or 11.1** or newer (`core_version_requirement: ^10.4 || ^11.1`;
  the project notes Drupal **10.3+**, since it relies on the Recipe API).
- The **Recipe API**, which is included in Drupal core from 10.3 onward — no extra
  module needed.

There are no third‑party Composer packages or PHP libraries to install.

> **Security reminder:** this module installs code bundled inside recipes, which is
> effectively running arbitrary code. Only ever apply recipes from sources you
> trust, and review bundled code first. See the [main guide](../index.md) for the
> full trust boundary.

## Install with Composer

From the project root:

```bash
composer require drupal/recipe_code_installer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recipe_code_installer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recipe_code_installer -y
```

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pml | grep recipe_code_installer`).
There's nothing to configure — the next time you apply a **trusted** recipe that
contains a `code/` module, Recipe Code Installer extracts and installs it as the
final step. See the [main guide](../index.md#how-to-use-it) for the workflow.
