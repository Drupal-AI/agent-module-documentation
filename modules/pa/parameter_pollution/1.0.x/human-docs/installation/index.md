# Installation

## Requirements

HTTP Parameter Pollution is deliberately lightweight:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other modules, PHP libraries, or Composer dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/parameter_pollution -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/parameter_pollution -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en parameter_pollution -y
```

That is all it takes. There is no required — or optional — configuration.

## Verify it worked

Visit any page on your site with a deliberately duplicated query parameter, for
example:

```
https://example.com/?test=1&test=2
```

If the module is active, your browser is redirected to the cleaned URL keeping
only the last value (`?test=2`). Seeing that redirect confirms HTTP Parameter
Pollution is normalizing requests as intended.
