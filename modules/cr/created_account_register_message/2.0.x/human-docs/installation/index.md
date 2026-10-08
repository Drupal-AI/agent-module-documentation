# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required — it builds only on core's user registration form.

Before enabling, decide whether the account-enumeration trade-off described on the
[overview page](../index.md) is acceptable for your site. The module deliberately
tells anonymous visitors when an email or username already has an account.

## Install with Composer

From the project root:

```bash
composer require drupal/created_account_register_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/created_account_register_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en created_account_register_message -y
```

That's all it takes — there is no settings form to fill in.

## Verify it worked

Log out (or use a private browser window), go to the user registration form, and
try to register with an email address that already belongs to an account. Instead
of core's "already in use" error you should see the module's friendly message, and
the account owner should receive a password reset email.
