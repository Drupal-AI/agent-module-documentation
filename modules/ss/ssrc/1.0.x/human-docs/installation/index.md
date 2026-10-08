# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies, and no third-party PHP or JavaScript libraries.

It works alongside Drupal's core account-registration settings, so make sure your
site actually allows visitors to register (**Configuration → People → Account
settings**) for the code field to have anything to gate.

## Install with Composer

From the project root:

```bash
composer require drupal/ssrc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ssrc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ssrc -y
```

Or enable **Simple Secret Registration Code** from the Extend page
(`/admin/modules`).

## Verify it worked

After enabling, go to **Configuration → Manage secret registration code**
(`/admin/config/ssrc`). If the management form loads, the module is installed —
continue to [Configuration](../configuration/index.md) to add a code and turn the
feature on. Nothing changes on the registration form until you do.
