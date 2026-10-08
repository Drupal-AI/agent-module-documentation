# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 | ^11.0`).
- **Google reCAPTCHA keys** — a site key and secret key from Google's reCAPTCHA
  admin console (<https://www.google.com/recaptcha/admin>). These are not a
  Composer dependency, but the challenge cannot be verified without them.

The module has no dependencies on other Drupal modules and no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_recaptcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_recaptcha -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_recaptcha -y
```

Out of the box the module protects the password‑reset and user‑registration
forms (`user_pass`, `user_register_form`). You will still need to enter your
Google keys before the challenge can verify — see
[Configuration](../configuration/index.md).

## Optional submodule — Webform

Simple Google reCaptcha ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Simple reCAPTCHA Webform** | `simple_recaptcha_webform` | A Webform handler so you can enable reCAPTCHA per webform, instead of (or as well as) by form ID. |

Enable it only if you use the Webform module:

```bash
drush en simple_recaptcha_webform -y
```
