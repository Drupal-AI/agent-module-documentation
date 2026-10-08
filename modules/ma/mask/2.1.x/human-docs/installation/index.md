# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other contrib module dependencies, and no third-party PHP libraries.
- The jQuery Mask Plugin JavaScript library, which the module loads for you —
  either from a CDN (the default) or from a copy stored on your own site. See
  [Configuration](../configuration/index.md) for the choice between the two.

## Install with Composer

From the project root:

```bash
composer require drupal/mask -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mask -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mask -y
```

Once enabled, the module adds **Mask settings** to the supported field widgets on
your Manage form display screens. No field is masked until you set a mask on it —
see [Configuration](../configuration/index.md).
