# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No other modules, no third‑party Composer packages, and no PHP library
  requirements.

> **Reminder:** this is a testing tool. Install and enable it only on
> **development or staging** environments — never on production. See the warning
> in the [overview](../index.md#-this-is-a-testing-tool--never-run-it-on-production).

## Install with Composer

From the project root:

```bash
composer require drupal/mail_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_redirect -y
```

Once enabled, **configure it right away** so it knows where to send the redirected
mail — see [Configuration](../configuration/index.md).

## Verify it worked

After configuring a target, trigger any email from the site (a password reset is a
good test) and confirm it arrives at your **test** address/domain rather than the
original recipient. If it lands in the test inbox, the redirect is active.

## Keeping it off production

Because leaving this enabled on a live site is harmful, keep it out of your
production configuration entirely — for example by only enabling it in
environment-specific settings, or by making sure it is uninstalled before code
reaches production.
