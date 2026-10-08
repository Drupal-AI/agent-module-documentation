# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** (`user`) and **Configuration Translation**
  (`config_translation`) modules. Config Translation is a hard dependency and makes
  the role descriptions translatable; Drupal enables it automatically.
- No third-party Composer or PHP libraries.
- *Optional:* the **Role Delegation** module — Role description works with its widget
  too, but it is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/role_description -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_description -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_description -y
```

Drupal enables the `config_translation` dependency at the same time.

## Verify it worked

Log in as a user with the **Administer permissions** permission and go to **People →
Role description** (`/admin/people/role-description`). Enter a description for a role
and save, then open the user account form and confirm the description appears beside
that role's checkbox. See *How to configure it* on the [overview page](../index.md)
for details.
