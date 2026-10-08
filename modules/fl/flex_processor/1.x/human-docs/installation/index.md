# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Flex Processor has no other module dependencies and no third‑party PHP library
requirements. (Note that this branch is a beta release — `1.0.0-beta4` — so treat
it accordingly on production sites.)

## Install with Composer

From the project root:

```bash
composer require drupal/flex_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flex_processor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flex_processor -y
```

## Verify it worked

Flex Processor has no admin page — it's a framework you use from code. To confirm
it's available, check that the module is enabled (**Extend**, or
`drush pml --status=enabled | grep flex_processor`) and that the
`plugin.manager.flex_processor` service resolves. From there, define a
DataProcessor plugin in your own module and invoke it as shown in the
[overview](../index.md#how-to-use-it-for-developers).
