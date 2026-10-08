# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies, no third‑party Composer requirements, and no PHP
extension requirements beyond what a standard Drupal install provides. (XML
dumping uses PHP's built‑in XML parser.)

## Install with Composer

From the project root:

```bash
composer require drupal/dbug -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Because this is a development tool, you may prefer to
require it as a dev dependency (`composer require --dev drupal/dbug`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dbug -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dbug -y
```

There is no configuration to do. Once enabled, call
`\Drupal\dbug\Dbug::debug($var)` from your code — see [How to use
it](../index.md#how-to-use-it) in the overview.

## Submodules

dBug ships no submodules.
