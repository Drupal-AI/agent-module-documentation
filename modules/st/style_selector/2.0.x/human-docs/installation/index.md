# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Options** module (`options`) — the only dependency, enabled
  automatically as a dependency. The field types build on core's list/options
  behaviour.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions of its own (the settings page uses core's **Administer site
configuration**).

## Install with Composer

From the project root:

```bash
composer require drupal/style_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/style_selector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_selector -y
```

## Optional demo submodule

Style Selector ships one optional submodule, **Style Selector Demo**
(`style_selector_demo`), which provides sample CSS libraries and preconfigured
styles so you can see the picker working before wiring up your own design system.
It is handy for evaluation but not needed in production:

```bash
drush en style_selector_demo -y
```

## Verify it worked

Visit **Configuration → User interface → Style Selector**
(`/admin/config/user-interface/style-selector`) to confirm the settings page
loads, then add a **Style list** or **Color list** field to any content type under
**Manage fields**. See [Configuration](../configuration/index.md) for the full
setup.
