# Installation

## Requirements

Password Policy Pwned Passwords needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Password Policy** module (`drupal/password_policy`) — this module adds a
  constraint *to* Password Policy, so it can't do anything without it. Composer
  pulls it in automatically.
- **Outbound HTTPS access** from your site to `https://api.pwnedpasswords.com` so
  the breach check can run. (If the API is unreachable the constraint fails open
  and allows the password.)

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/password_policy_pwned -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `drupal/password_policy`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/password_policy_pwned -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en password_policy_pwned -y
```

Drupal enables the required **Password Policy** module at the same time as a
dependency.

There is no configuration form to visit. Instead, add the **Pwned Passwords**
constraint to a password policy and assign that policy to roles — see the
[overview](../index.md#how-to-use-it).
