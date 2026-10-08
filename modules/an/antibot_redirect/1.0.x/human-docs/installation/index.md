# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **reCAPTCHA** module (`recaptcha`), which provides the challenge and stores
  your reCAPTCHA keys. Composer installs it for you.
- reCAPTCHA site and secret keys from Google, entered in the reCAPTCHA module's
  settings.

## Install with Composer

From the project root:

```bash
composer require drupal/antibot_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the reCAPTCHA module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/antibot_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en antibot_redirect -y
```

Drupal enables the reCAPTCHA dependency at the same time. Before AntiBot Redirect
can challenge anyone, configure the reCAPTCHA module with your keys, then set which
pages and redirects to protect (see the [overview](../index.md#how-to-use-it)).
