# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party libraries or extra module dependencies beyond Drupal core.

## Install with Composer

The module's machine name is `ip_country_logger`, but it ships in the
**`country_trace`** project, so that is the package name you require:

```bash
composer require drupal/country_trace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/country_trace -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its machine name (not the project name):

```bash
drush en ip_country_logger -y
```

## Verify it worked

Once enabled, the module begins logging the country resolved from each visitor's
IP automatically. Browse the site (ideally generating a request from a known
location) and check that country entries are being recorded. There is no settings
page to configure — enabling the module is the whole setup.
