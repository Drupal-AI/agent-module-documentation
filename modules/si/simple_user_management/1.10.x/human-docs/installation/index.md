# Installation

## Requirements

Simple User Management needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Role Delegation** module (`drupal/role_delegation` `^1.2`), which bounds
  which roles a delegated manager may assign and act on. Composer pulls it in
  automatically, and it is central to the module's safety model.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_user_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `drupal/role_delegation`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_user_management -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_user_management -y
```

Drupal enables the required **Role Delegation** module at the same time.

## Set it up

There is no configuration form. To make the module useful you grant permissions to a
delegating role and adjust the People view so that role can reach the user list — the
full step‑by‑step (including the Role Delegation permissions and a Drush shortcut) is
in the [overview](../index.md#how-to-use-it).
