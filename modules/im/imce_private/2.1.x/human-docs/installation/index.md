# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[IMCE](https://www.drupal.org/project/imce)** module (`drupal/imce ^3.1`) —
  a hard dependency. It provides the file manager, the per‑scheme access profiles,
  and the CKEditor integration this module builds on.
- A configured **private file system** (set `$settings['file_private_path']` in
  `settings.php`) if you want the private buttons to be useful.
- *Optional but recommended:* the
  [Private files download permission](https://www.drupal.org/project/pfdp) module
  for defining who may download the browsed private files.

There are no third‑party Composer or PHP library requirements beyond IMCE.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_private -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in IMCE and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imce_private -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_private -y
```

This also enables IMCE if it is not already on. There are no submodules.

## Next step

The buttons still need to be added to a text format's toolbar, and IMCE must grant
your roles access to the relevant scheme — see
[Configuration](../configuration/index.md).
