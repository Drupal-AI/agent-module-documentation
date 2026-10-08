# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other module dependencies and no third-party Composer or PHP libraries.

Before you configure a login field, make sure it satisfies the module's two rules:

- The field's **values must be unique** across all user accounts, so a value maps
  to exactly one account.
- The field's **values must not contain special symbols or spaces** — use a plain,
  clean identifier.

## Install with Composer

From the project root:

```bash
composer require drupal/field_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_login -y
```

## Verify it worked

Go to **Configuration → People → Account settings → Field login**
(`/admin/config/people/accounts/field-login`). If the settings form loads and lets
you pick a login field, the module is installed. Choose your field (see
[Configuration](../configuration/index.md)), then test by logging in with that
field's value and the account's normal password.
