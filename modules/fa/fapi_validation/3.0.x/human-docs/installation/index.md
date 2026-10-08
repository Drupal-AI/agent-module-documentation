# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No module dependencies — it extends Drupal core's Form API.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fapi_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fapi_validation -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fapi_validation -y
```

The `#validators` and `#filters` keys are now available in any form built on the site.

## Optional example submodule

The project ships an example submodule that demonstrates attaching validators and
filters. Enable it if you want a worked reference to study:

```bash
drush en fapiv_example -y
```

(The example submodule's machine name is `fapiv_example`; it lives inside the same
project and depends on `fapi_validation`.)

## Verify it worked

Add a `#validators` entry to a form element in your custom code (see "How to use it" in
the [overview](../index.md)) and submit an invalid value — you should see the
validation error the rule produces. Since the module has no admin UI, there is nothing
else to check in the interface.
