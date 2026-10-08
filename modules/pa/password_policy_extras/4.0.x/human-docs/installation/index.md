# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Password Policy** module, version **^4.0** (`drupal/password_policy`). This is a hard
  dependency — Password Policy Extras enhances it and cannot run without it. Composer pulls it
  in automatically.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/password_policy_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Password Policy and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/password_policy_extras -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en password_policy_extras -y
```

Enabling it also enables Password Policy (if it wasn't already). The AJAX-refreshing status
table is active immediately with sensible defaults; adjust the behaviour on the
[Configuration](../configuration/index.md) page.

## Submodules — enable only what you need

The submodules integrate Password Policy with password forms provided by **other** contrib
modules. Enable a submodule only if you run the matching module:

| Submodule | Machine name | Integrates with |
|---|---|---|
| **Password Policy Change Pwd Page** | `password_policy_change_pwd_page` | Password Separate Form (`change_pwd_page`) |
| **Password Policy PRLP** | `password_policy_prlp` | Password Reset Landing Page (`prlp`) |
| **Password Policy User Registration Password** | `password_policy_user_registrationpassword` | User Registration Password (`user_registrationpassword`) |

For example:

```bash
drush en password_policy_prlp -y
```

Each submodule requires the base Password Policy Extras module, which is already present once
you have installed it above.
