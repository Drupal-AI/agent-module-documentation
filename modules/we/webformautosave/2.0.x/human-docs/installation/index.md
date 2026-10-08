# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`drupal/webform`, `^6.0`) — a Composer dependency,
  installed automatically.
- The **Webform Submission Log** submodule (`webform_submission_log`), which ships
  with Webform. It is required as a dependency and is used by the optimistic
  locking feature to read change timestamps.

There are no third‑party Composer or PHP library requirements beyond Webform
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/webformautosave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webformautosave -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webformautosave -y
```

Drupal enables Webform and the Webform Submission Log submodule at the same time
as dependencies. There are no submodules of its own.

Autosave does nothing until you switch it on for a specific webform — head to
[Configuration](../configuration/index.md).
