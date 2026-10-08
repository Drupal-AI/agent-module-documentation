# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which every Drupal site has.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/administrator_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/administrator_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en administrator_login -y
```

There is no configuration step — once enabled, the login and password-reset forms
begin rejecting non-administrator accounts.

> **Before you rely on it:** this restriction only covers the HTML forms. As
> explained in the [overview](../index.md), the core JSON login endpoint and other
> authentication providers are **not** blocked, so a non-admin can still
> authenticate through them. For a genuine administrators-only lockdown, enforce
> the rule at the authentication layer and disable/deny the JSON login and any
> REST or basic-auth providers for non-admins.
