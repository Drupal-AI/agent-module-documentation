# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). For Drupal 10, use the
  Feature Flags Extensions 1.1.3+ release instead of this 2.0.x line.
- The **Feature Flags** module (`featureflags`) — a hard dependency, pulled in by
  Composer.
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/featureflags_extensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in the base Feature Flags module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/featureflags_extensions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en featureflags_extensions -y
```

This enables Feature Flags Extensions (and Feature Flags if it was not already on).

## Verify it worked

Go to **Configuration → Development → Feature Flags** and edit (or add) a flag. You
should now see the extra route/permission binding fields this module adds. You can
also test the Twig helper by adding `{% if featureflag_active("<your_flag>") %}…{%
endif %}` to a template and confirming it renders according to the flag's state.
