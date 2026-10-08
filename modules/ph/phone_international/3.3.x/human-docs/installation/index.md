# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), including Drupal 10
  and 11.
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency.
- The PHP library **`giggsey/libphonenumber-for-php` (^8.13)**, which Composer
  pulls in for you when you require the module. This is what parses and validates
  the numbers.

## Install with Composer

From the project root:

```bash
composer require drupal/phone_international -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the libphonenumber PHP library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phone_international -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phone_international -y
```

There are no submodules.

## Optional: install the JavaScript library locally

By default the country‑selector widget loads its intl‑tel‑input assets from a CDN.
If you would rather serve them from your own site, the module provides a Drush
command that downloads the library into your `libraries/` directory:

```bash
# installs into ./libraries/intl-tel-input
drush phone_international:plugin

# or target a specific path
drush phone_international:plugin sites/default/libraries
```

(The command has short aliases `piplugin` and `pi-plugin`.) After downloading it,
turn the CDN setting **off** on the settings page so the widget uses your local
copy — see [Configuration](../configuration/index.md).
