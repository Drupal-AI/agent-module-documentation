# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

Min Password needs nothing beyond Drupal core — there are no module dependencies
and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/min_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/min_password -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en min_password -y
```

Once enabled, a minimum-password-length field appears on the core Account settings
page. Set your desired length there (see [Configuration](../configuration/index.md)).

## Verify it worked

Go to **Configuration → People → Account settings**
(`/admin/config/people/accounts`) and confirm the minimum password length field is
present. Set it to a value (for example 12), save, then try to set a shorter
password on a user account — Drupal should reject it with a validation message.
