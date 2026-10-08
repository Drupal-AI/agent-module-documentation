# Installation

## Requirements

Webform XLSX Export needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module (`drupal/webform` `^6.2`) enabled — the exporter plugs into
  Webform's results-export system.
- The **PhpSpreadsheet** PHP library (`phpoffice/phpspreadsheet` `^3.5`) — this is what
  actually writes the `.xlsx` files. Composer installs it as a dependency; you do not
  install it separately.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_xlsx_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies and
pull in PhpSpreadsheet at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_xlsx_export -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_xlsx_export -y
```

That is the entire install — there is no configuration to do. The **XLSX** option now
appears on every webform's Download tab and via `drush webform:export --exporter=xlsx`.

## Verify it worked

Open the site **Status report** at `/admin/reports/status`; it reports whether
PhpSpreadsheet is installed. If that check is green, download a webform's results with the
**XLSX** format selected and confirm the file opens in Excel without a format warning.
