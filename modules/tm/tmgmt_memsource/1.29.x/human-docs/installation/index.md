# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Translation Management Tool (TMGMT)](https://www.drupal.org/project/tmgmt)**
  module (`tmgmt`) — the framework this provider plugs into.
- TMGMT's **File translator** submodule (`tmgmt_file`) — used to export content to
  XLIFF for upload to Phrase.
- A **Phrase TMS account** (phrase.com) with a user name and password you can use
  to log in via the API, plus your Phrase TMS *Home URL*.

Composer pulls the TMGMT modules in for you; the Phrase account is external.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_memsource -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch TMGMT and its
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_memsource -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drupal will offer to enable TMGMT and
the file translator automatically):

```bash
drush en tmgmt_memsource -y
```

## What to do next

Enabling the module makes a **Phrase** translator plugin available inside TMGMT.
You still need to create a Provider with your Phrase TMS credentials before you
can send anything for translation — see [Configuration](../configuration/index.md).
