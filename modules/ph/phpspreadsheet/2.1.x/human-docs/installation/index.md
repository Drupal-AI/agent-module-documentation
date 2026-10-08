# Installation

## Requirements

PhpSpreadsheet is deliberately lightweight. It needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **PHPOffice/PhpSpreadsheet** PHP library (`phpoffice/phpspreadsheet:~1`),
  which Composer pulls in automatically when you require the module.

There are no other module dependencies, and no configuration to prepare.

## Install with Composer

From the project root:

```bash
composer require drupal/phpspreadsheet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and this is also what installs the underlying
`phpoffice/phpspreadsheet` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phpspreadsheet -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpspreadsheet -y
```

That's all it takes. There is no configuration and no admin page — the library
classes are now available to any module that depends on PhpSpreadsheet.

## Verify it worked

Confirm the module is enabled (it appears under **Extend**, or `drush pml
--filter=phpspreadsheet` shows it as *Enabled*). Whatever module required
PhpSpreadsheet should now be able to generate or parse spreadsheet files without
a "class not found" error.
