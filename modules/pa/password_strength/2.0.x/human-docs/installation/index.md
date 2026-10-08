# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Password Policy** module (`drupal/password_policy`, `^3.1 || ^4.0`) — this is a hard
  dependency and Composer installs it for you.
- The **zxcvbn‑php** library (`bjeavons/zxcvbn-php`, `^1.3`) — the scoring engine, also
  pulled in automatically by Composer.

> **Heads up:** the installed 2.0 release is a **beta** (`8.x-2.0-beta4`). Test it on a
> non‑production environment before rolling it out to real users.

## Install with Composer

From the project root:

```bash
composer require drupal/password_strength -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Password Policy and the
zxcvbn library and update any shared dependencies as needed. Because the zxcvbn scoring
library is a real Composer package, install through Composer — don't just download the
module's ZIP, or the library will be missing.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/password_strength -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en password_strength -y
```

Enabling `password_strength` also enables `password_policy` if it isn't already on. There are
no submodules.

## After enabling

Enabling the module does not enforce anything yet — you must add the **Password Strength**
constraint to a Password Policy and assign that policy to roles. Continue to
[Configuration](../configuration/index.md).
