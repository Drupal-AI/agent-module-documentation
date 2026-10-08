# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **File** field — this is the field the formatter attaches to. It ships
  with Drupal core; enable the **File** module if it isn't already on.
- No PHP library requirements.
- **DataTables** JavaScript library — *optional*. By default the module can load
  DataTables from the DataTables CDN. Only if you want to serve it from your own
  server (the formatter's "Load from local files" option) do you need to install
  it locally — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/csvfile_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/csvfile_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csvfile_formatter -y
```

## Optional: install DataTables locally

If you want the "Load from local files" option instead of the CDN, add the
DataTables libraries with Composer. First allow libraries to install into
`web/libraries`:

```bash
composer require mnsami/composer-custom-directory-installer
```

Then add the DataTables paths under `extra` → `installer-paths` in your
`composer.json`:

```json
"web/libraries/{$name}": [
    "datatables.net/datatables.net",
    "datatables.net/datatables.net-dt",
    "type:drupal-library"
],
```

Finally require the library:

```bash
composer require datatables.net/datatables.net-dt
```

## Verify it worked

Add a File field to a content type, go to that type's **Manage display**, and
confirm that **CSV File as Table** appears in the format dropdown for the field.
Upload a CSV through the field on a piece of content and view it — the file should
render as an HTML table rather than a download link.
