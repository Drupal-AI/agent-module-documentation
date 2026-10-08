# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
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

The module works immediately with its default rules (see below). You can then tune
them on the settings form — head to [Configuration](../configuration/index.md).

## What the defaults are

Out of the box, the policy is configured with these rules:

- Minimum length: **12**
- Minimum lowercase, uppercase, numeric and special characters: **1** each
- Password history and similarity-to-username checks: **off** (empty)
- Passwords expire after **1 year**, with a warning **3 weeks** ahead
- A default list of ignored routes (such as the logout and password-reset routes)
  where the expiry check is skipped

## Verify it worked

Log in as an administrator and visit
`/admin/config/people/password_policy` — you should see the **Password policy**
settings form. To confirm enforcement, try setting an account's password to
something weak (for example `abc`): the form should reject it with an error
explaining which rule it failed.
