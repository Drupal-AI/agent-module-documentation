# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Field UI** module (`field_ui`), since the module edits Field UI's
  add-field prefix. Enable it if it isn't already on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_prefix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_prefix -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_prefix -y
```

## Verify it worked

Go to `admin/config/field_prefix/setting`
(`/admin/config/field_prefix/setting`). If the settings form loads, the module is
installed. Set your desired prefix (or clear it), save, then add a new field on any
bundle to confirm the machine name uses your new prefix. See
[Configuration](../configuration/index.md) for details.

> **Optional:** once you've set the prefix you want, you can uninstall the module —
> the change persists in `field_ui.settings`. Keeping the module installed simply
> lets you revisit the form later.
