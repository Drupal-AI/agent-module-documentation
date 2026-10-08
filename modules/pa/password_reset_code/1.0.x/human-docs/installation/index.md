# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10||^11`, with the
  project page noting Drupal 10.1+ / 11 / 12).
- **PHP 8.0 or higher.**
- A working outbound email setup on your site — the whole flow depends on users
  receiving the reset code by email.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/password_reset_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/password_reset_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en password_reset_code -y
```

You can also enable it from **Administration → Extend** in the UI.

## Permissions

The module provides an **Administer password reset codes** permission, which grants
full access to the password‑reset‑code functionality (configuring policies and
managing active codes). Grant it only to trusted administrator roles under
**Administration → People → Permissions**.

## Verify it worked

After enabling, go to **Administration → Configuration → People → Password reset by
code** and confirm the settings form loads. Then test the flow end to end: request
a password reset for a test account, confirm the email arrives with a verification
code, and complete the reset. See [Configuration](../configuration/index.md) to
tune the expiry, attempt limit, and messages first.
