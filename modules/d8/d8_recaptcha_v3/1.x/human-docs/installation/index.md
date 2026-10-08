# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **No dependency on the CAPTCHA module** — this integration is self‑contained.
- A **Google reCAPTCHA v3 key pair** (site key + secret key), created in the
  [Google reCAPTCHA admin console](https://www.google.com/recaptcha/admin). You
  need this before the module can protect any forms.

## Install with Composer

From the project root:

```bash
composer require drupal/d8_recaptcha_v3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/d8_recaptcha_v3 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en d8_recaptcha_v3 -y
```

## Verify it worked

Open the module's settings form in the **Configuration** area and confirm it
loads with fields for the site key, secret key, and score threshold. Enter your
Google keys and choose which forms to protect — see
[Configuration](../configuration/index.md).
