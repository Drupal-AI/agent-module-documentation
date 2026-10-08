# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Core's **User** module (`user`), which is part of a standard Drupal install and is
  enabled automatically as a dependency.
- No PHP extensions or external Composer libraries are listed as required.
- Note this release is an **alpha** (2.0.0-alpha2) and the module is **not covered by
  the security advisory policy**, so test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/system_account -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/system_account -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en system_account -y
```

Enabling the module adds the `system_account` base field to user entities. If other
installed modules ship a system account via `system_account.account.<module>.<id>`
configuration, those accounts are provisioned on install — but only if no existing
user already matches the account's name or email.

## Verify it worked

Go to **Configuration → People → System Account**
(`/admin/config/people/system-account`) and confirm the settings form loads. See
[Configuration](../configuration/index.md) to set the display name.
