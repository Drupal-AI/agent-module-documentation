# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No module dependencies, and no third-party Composer or front-end library
  requirements — it builds on core's Form API.

## Install with Composer

From the project root:

```bash
composer require drupal/declarative_form_ajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/declarative_form_ajax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en declarative_form_ajax -y
```

## Submodule: the demo

To see the declarative syntax working end to end, enable the bundled demo module,
which provides example forms:

```bash
drush en declarative_form_ajax_demo -y
```

It's a learning aid — enable it on a development site, study its forms, then
disable it once you've copied the pattern into your own code.

## Verify it worked

Confirm the module is enabled (`drush pml | grep declarative_form_ajax`). The real
test is functional: if you enabled the demo submodule, open its example form and
change a controlling field — a dependent element should refresh via AJAX without
any custom callback code. See
[How to use it](../index.md#how-to-use-it) in the main guide for how to apply the
API in your own forms.
