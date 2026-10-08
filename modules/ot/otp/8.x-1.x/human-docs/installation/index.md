# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A working outbound **email** configuration on the site, since the whole flow
  depends on delivering the verification code by email.

There are no contributed module dependencies and no extra PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/otp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/otp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en otp -y
```

## Verify it worked

As an administrator, visit `/admin/config/people/otp` to confirm the settings form
is available (see [Configuration](../configuration/index.md)). Then register a
test account: after submitting the *Create new account* form you should be shown a
code‑entry form and receive a verification code by email. Entering the correct
code should activate the account and log you in.
