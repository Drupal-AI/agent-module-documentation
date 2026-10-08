# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Field** (`field`) and **User** (`user`) modules — both part of a
  standard Drupal install.
- The contributed **Token** module (`token`) — Composer pulls this in
  automatically as a dependency.

There are no additional PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/displayname -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Token
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/displayname -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en displayname -y
```

Enabling Display Name also enables Token if it isn't already on.

## Verify it worked

Go to **Configuration → People → Account settings → Manage fields**
(`/admin/config/people/accounts/fields`) and add a field. You should see the
module's display‑name field type(s) available in the field‑type list. Add one,
then check the **Manage form display** and **Manage display** tabs to place it on
the account form and the user profile.
