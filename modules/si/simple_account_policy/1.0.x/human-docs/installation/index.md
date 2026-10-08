# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **User** module (`user`), which is always present. No other modules are
  required.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_account_policy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_account_policy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_account_policy -y
```

The module installs with a set of default rules already in place (username must
match email, block after three months of inactivity, warn three weeks before,
remove after a year). Because those defaults are active immediately, **review the
configuration before leaving it running** — in particular decide which accounts
should be exempt from automatic blocking. See
[Configuration](../configuration/index.md).

## Grant the permissions

The module adds three restricted-access permissions at **People → Permissions**:

- **Administer account policy** — change the policy rules.
- **Account policy activate users** — unblock users (a sensitive account-recovery
  capability).
- **Account policy block users** — block users.

Grant these deliberately, to trusted roles only.
