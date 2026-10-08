# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.
- **Optional:** the **CAPTCHA** module, if you want to enable the shipped CAPTCHA
  protection on the subscribe and unsubscribe forms.
- A working outbound mail setup on your site, since the module sends confirmation
  and notification emails.

## Install with Composer

From the project root:

```bash
composer require drupal/supermailer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/supermailer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en supermailer -y
```

## After enabling

There is no admin settings page yet, so after enabling you will:

1. Place the **Supermailer subscribe** and/or **unsubscribe** blocks under
   **Structure → Block layout**.
2. Set the `supermailer.settings` configuration (recipient address, subscribe-OK
   page, token expiry) through configuration management or by editing
   `supermailer.settings.yml`.

See the [main guide](../index.md) for the details of each setting.
