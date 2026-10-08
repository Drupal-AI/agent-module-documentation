# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **REST** (`rest`) and **Views** (`views`) modules.
- The **Views Data Export** contrib module (`drupal/views_data_export`, `~1`) —
  this module extends it, so it must be present.
- The **PhpSpreadsheet** PHP library (`phpoffice/phpspreadsheet`, `^1 || ^2 ||
  ^3`) — this is what actually writes the spreadsheet files. Composer installs it
  for you.

## Install with Composer

From the project root:

```bash
composer require drupal/views_data_export_phpspreadsheet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Views Data
Export and the PhpSpreadsheet library, updating any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_data_export_phpspreadsheet
> -W`, `ddev drush …`. Inside the container (`ddev ssh`) run them without the
> prefix.

## Enable the module

```bash
drush en views_data_export_phpspreadsheet -y
```

Enabling it also enables Views Data Export, Views, and REST if they aren't
already on. There is no configuration form to visit afterwards — the "Xlsx
export" style becomes available on Data Export displays immediately.

## Verify it worked

Edit any View, add or open a **Data export** display, and change its
**Format/Style**. You should now see **Xlsx export** in the list of style
plugins. Selecting it reveals the **xlsx Settings** options group described in
the [main guide](../index.md#how-to-use-it).
