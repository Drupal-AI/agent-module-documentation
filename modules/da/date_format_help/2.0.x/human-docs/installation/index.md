# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module, Composer, or PHP library dependencies — it uses Drupal core only.

## Install with Composer

From the project root:

```bash
composer require drupal/date_format_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_format_help -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_format_help -y
```

That's all — there is no configuration.

## Verify it worked

Go to **Configuration → Regional and language → Date and time formats**
(`/admin/config/regional/date-time`) and add or edit a format. On that page you
should now see the inline PHP `date()` format‑character reference explaining what
each token means.
