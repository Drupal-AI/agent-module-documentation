# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`; the
  project also declares support up to Drupal 12).
- No module dependencies, no submodules, and no third-party PHP or library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/secret_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/secret_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en secret_login -y
```

## Verify it worked

The module does nothing until you configure a secret URL. Head to
[Configuration](../configuration/index.md) to create one — and to review the
precautions you should take first.
