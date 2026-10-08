# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`) — always present.
- The **Token** module (`token`) — used so your custom messages can include tokens.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eep -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Token dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/eep -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eep -y
```

Drupal will enable Token as a dependency if it is not already on.

## Verify it worked

Log in as an administrator and open **Configuration → EEP settings**. If the form
loads, installation succeeded. The protection is not fully active until you enable
it on each form — see [Configuration](../configuration/index.md).
