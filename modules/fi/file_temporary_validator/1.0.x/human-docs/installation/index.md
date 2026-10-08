# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. Note this is a
**beta** release (`1.0.0-beta4`); test it on a non-production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/file_temporary_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_temporary_validator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_temporary_validator -y
```

## Verify it worked

Enabling the module does nothing on its own — the validation is switched on per
field. Turn it on for a file field (see "How to use it" in the
[overview](../index.md)), then upload a file, and — without leaving the form —
attempt to upload another file with the same name. You should see the duplicate
alert, confirming the validator is active on that field.
