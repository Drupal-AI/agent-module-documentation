# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module dependencies — this module simply provides the PapaParse
  JavaScript library.

## Install with Composer

From the project root:

```bash
composer require drupal/papaparse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/papaparse -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en papaparse -y
```

## Verify it worked

There is no UI to check. Confirm it another way: enable the module that depends on
PapaParse and exercise its CSV feature, or attach the `papaparse/papaparse` library
from your own code and confirm the PapaParse JavaScript API is available in the
browser.
