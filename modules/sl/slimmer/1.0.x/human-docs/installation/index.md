# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependent Drupal modules and no third-party PHP or Composer libraries.

Note the module is **not covered by the security advisory policy**, so apply
your own judgement before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/slimmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slimmer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slimmer -y
```

There is nothing to configure. Once enabled, custom code can depend on Slimmer
and use its central logging helper. Remember not to log secrets or personal data.
