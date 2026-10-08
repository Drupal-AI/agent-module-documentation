# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.0 or newer** (`php: >=8.0`).
- The PHP **`ext-intl`** extension (`ext-intl: *`). This is the one requirement to
  verify up front — it is not enabled on every PHP install, and IntlDate will fail
  at install time without it.

## Check for ext-intl first

Before installing, confirm the intl extension is present:

```bash
php -m | grep intl
```

If it prints `intl`, you're set. If it prints nothing, enable the extension in your
PHP configuration (or your hosting control panel) before continuing.

> **Using DDEV?** The `intl` extension is included in DDEV's default web image, so
> it is normally available in the container out of the box — check with
> `ddev exec 'php -m | grep intl'`.

## Install with Composer

From the project root:

```bash
composer require drupal/intl_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will also enforce the `ext-intl` and PHP 8.0
requirements at this step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/intl_date -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en intl_date -y
```

## Verify it worked

Go to **Configuration → Regional and language → IntlDate**
(`/admin/config/regional/intl-date-time`). If the admin page opens, the module is
installed and the intl extension is available. Continue to
[Configuration](../configuration/index.md) to create your first ICU date format.
