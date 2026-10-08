# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other Drupal module dependencies, and no third‑party Composer or PHP library
  requirements.

> **Before you install:** this module is **obsolete and unsupported**, and it is
> **not covered by the security advisory policy**. Install it only if you need it
> for an existing site or as a code reference — not for new work.

## Install with Composer

From the project root:

```bash
composer require drupal/plugin_config_form_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugin_config_form_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugin_config_form_builder -y
```

## Verify it worked

This module has no user‑facing page, so there is nothing to click. Once
`drush pm:list` shows it as **Enabled**, its abstract plugin config‑form element
is available for your own plugin code to build on.
