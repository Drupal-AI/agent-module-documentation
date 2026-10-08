# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), part of a standard Drupal install.
- No third-party Composer or PHP libraries.

## Install with Composer

The drupal.org project is named `role_switcher_session` even though the module's
machine name is `role_switcher`, so require it by the **project** name:

```bash
composer require drupal/role_switcher_session -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_switcher_session -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `role_switcher`:

```bash
drush en role_switcher -y
```

## Verify it worked

Log in as a user who holds more than one custom role and visit `/user/role-switch`.
You should see the "Acting as" dropdown listing your switchable roles plus "All my
original roles". Optionally add the **Role Switcher block** via **Structure → Block
layout**. There is nothing to configure — see *How to use it* on the
[overview page](../index.md).
