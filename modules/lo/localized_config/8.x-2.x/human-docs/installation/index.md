# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1** or newer.
- Core's **Language**, **User**, and **File** modules (enabled automatically as
  dependencies).
- A developer to write (or adapt) a configuration plugin — remember this is a
  framework, not a turnkey feature.

## Install with Composer

From the project root:

```bash
composer require drupal/localized_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localized_config -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localized_config -y
```

## See a working example

The project ships a submodule, **Localized Configuration Example**
(`localized_config_example`), containing example code for a custom plugin. Enable
it to see the framework in action and use it as a reference when writing your own:

```bash
drush en localized_config_example -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Localized configuration →
Settings** (`/admin/config/localized/settings`). If you enabled the example
submodule, you should also see its plugin available to enable and edit. Continue
to [Configuration](../configuration/index.md).
