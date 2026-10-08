# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A working outbound **mail setup**, since the whole flow depends on the
  verification link reaching the visitor's inbox.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/email_verification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_verification -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_verification -y
```

## Verify it worked

Log in as an administrator (you need the **Administer users** permission) and go
to **Configuration → People → New User Email Verification**
(`/admin/config/people/userverify`). If the settings form loads, the module is
installed. Set a verification key and template as described in
[Configuration](../configuration/index.md), then test the flow by visiting the
registration page as an anonymous visitor — you should be redirected to the
email‑verification step first.
