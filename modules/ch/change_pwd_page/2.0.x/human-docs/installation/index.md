# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (part of every standard install), enabled automatically as a
  dependency.
- Optional: the **Password Policy** module (`drupal/password_policy`). If present,
  this module integrates with it automatically so enforced password policies apply on
  the separate change-password form.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/change_pwd_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/change_pwd_page -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en change_pwd_page -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

Everything takes effect immediately and there is nothing to configure: the password
fields disappear from the account-edit form, the **Change Password** tab and account-menu
link appear, and the reset flow is rerouted to the separate page. If you also have
Password Policy enabled, its change-password route is pointed at the new form
automatically. See the [overview](../index.md#how-to-use-it) for how the pages work.
