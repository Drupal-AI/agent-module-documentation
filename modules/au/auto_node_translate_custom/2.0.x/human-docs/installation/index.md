# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Auto Node Translate** module (`auto_node_translate`) — this is a
  submodule-style extension of it and does nothing on its own.
- The **PhpSpreadsheet** library (`PhpOffice\PhpSpreadsheet`) to read the
  uploaded spreadsheet. Installing via Composer pulls this in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_node_translate_custom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Auto Node Translate and PhpSpreadsheet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_node_translate_custom -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_node_translate_custom -y
```

This also enables `auto_node_translate` if it is not already on.

## After enabling

- Grant the **`configure auto node translate custom`** permission (marked
  "restrict access") to trusted administrators at **People → Permissions**.
- Then upload your override spreadsheet at
  **`/admin/config/system/custom-translations`**, as described in
  [Configuration](../configuration/index.md).
