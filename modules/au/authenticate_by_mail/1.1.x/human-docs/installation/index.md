# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **User** module (`user`) — this is enabled on every Drupal site, and the
  module builds on core's one-time-login mechanism.
- No third-party Composer or PHP library requirements are declared.

A working **site email configuration** is essential in practice: with passwords out of
the flow, users can only log in if the mailed link reaches them.

## Install with Composer

From the project root:

```bash
composer require drupal/authenticate_by_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/authenticate_by_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en authenticate_by_mail -y
```

## Next steps

There is no settings page — the module layers directly onto core authentication.
Confirm your site can send email reliably, then have a user try the mailed-link login.
See [How to use it](../index.md#how-to-use-it).
