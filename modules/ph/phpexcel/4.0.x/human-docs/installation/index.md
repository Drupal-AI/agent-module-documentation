# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`phpoffice/phpspreadsheet ^1 || ^2`** PHP library — Composer installs this
  automatically when you require the module. (Unlike older versions of this module,
  the 4.0.x version manages the library through Composer, so there is no manual
  library download.)
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/phpexcel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the PhpSpreadsheet
library and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phpexcel -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpexcel -y
```

## Verify it worked

The quickest check is from code: fetch the service and write a test file, for
example with `\Drupal::service('phpexcel')->export([...], [...], 'public://test.xlsx')`,
then confirm the file appears. You can also visit **Configuration → Development →
PHPExcel** (`/admin/config/development/phpexcel`) to confirm the module's settings
page loads. See "How to use it" on the [overview page](../index.md) for the service
API.
