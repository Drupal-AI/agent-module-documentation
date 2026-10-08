# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **User** module (`user`), which is always present on a Drupal site. There
  are no other module dependencies.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_password_policy -W
```

The Composer package name (`drupal/simple_password_policy`) matches the module's
machine name (`simple_password_policy`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_password_policy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_password_policy -y
```

## What enabling does

The module works immediately with its default rules (a 12-character minimum, one of
each character class, expiry after 1 year with a warning 3 weeks ahead). Enabling it
also has two side effects worth knowing:

- It creates a password-history table and seeds it for your existing users (run as a
  batch), so the history rule has data to work with.
- It turns off core's built-in password-strength meter, since this module replaces it
  with explicit, enforced rules. Uninstalling the module restores the meter and drops
  the history table.

## Verify it worked

Log in as an administrator and visit `/admin/config/people/password_policy` — you
should see the **Password policy** settings form. To confirm enforcement, edit an
account and try setting a weak password (for example `abc`): the form should reject
it with an error naming the rule it failed. Head to
[Configuration](../configuration/index.md) to tune the rules.
