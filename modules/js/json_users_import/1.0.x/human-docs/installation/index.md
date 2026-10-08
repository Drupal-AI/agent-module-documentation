# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **SMTP Authentication Support** module (`drupal/smtp`) — a dependency, used
  to send the optional welcome emails. Composer pulls it in for you.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process. Because the module creates
> login-enabled accounts, be deliberate about who can reach it (see the access
> note below).

## Install with Composer

From the project root:

```bash
composer require drupal/json_users_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required SMTP
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/json_users_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_users_import -y
```

This also enables the SMTP module it depends on.

## A note on access before you go further

Both of the module's pages require a `json import users` permission, but the
module does not ship a definition for that permission. Until a developer defines
it, **only user 1 (the superuser) can reach the import and configuration forms** —
they will not appear on the People → Permissions page for you to grant to other
roles. This is stricter than you might expect, not looser, so plan for a developer
to add the permission if regular administrators need access.

## Verify it worked

Log in as the superuser (user 1) and go to
**`/admin/config/people/json_users_import_config`**. If the field-mapping form
loads, the module is installed. Next, set up your field and email mapping in
[Configuration](../configuration/index.md) before running your first import.
