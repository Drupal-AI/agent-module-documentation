# Installation

## Requirements

Empty Paragraph Killer is deliberately tiny. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module, which is part of standard Drupal and provides the text
  format system the filter plugs into.

There are no third-party Composer or PHP library requirements, and no other contrib
modules to install.

## Install with Composer

From the project root:

```bash
composer require drupal/emptyparagraphkiller -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emptyparagraphkiller -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emptyparagraphkiller -y
```

Enabling the module does nothing visible on its own — it just makes the **Empty
paragraph filter** available on your text formats. Turn it on where you want it by
following [How to use it](../index.md#how-to-use-it) in the overview.
