# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — part of Drupal core.
- The contributed **Vendor Stream Wrapper** module (`vendor_stream_wrapper`).
- The `scrivo/highlight.php` PHP library.

You do not need to install the module dependencies by hand: when you require the
module with Composer, both the `scrivo/highlight.php` library and the Vendor
Stream Wrapper module are pulled in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/ssch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ssch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ssch -y
```

Drupal enables the Field and Vendor Stream Wrapper dependencies automatically as
part of turning on this module.

## Verify it worked

Go to **Structure → Content types**, open **Manage fields** for any content type,
and start adding a field. **Code snippet (server-sided code highlighting)** should
appear in the list of available field types. If it does, the module and its
library are installed correctly — see the *How to use it* section of the
[main guide](../index.md) to configure the field's language and display.
