# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **User** module (always present) — the module hooks into the user account
  settings and account mails.

There are no additional module or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_account_emails -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_account_emails -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_account_emails -y
```

## Verify it worked

Go to **Configuration → People → Account settings**
(`/admin/config/people/accounts`) and look for the **Disable Account Emails**
fieldset. If it appears, the module is active. See
[Configuration](../configuration/index.md) for how to choose which emails to
disable — and which ones to leave on.
