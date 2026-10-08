# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). Drupal 9 is no
  longer supported as of 11.1.0.
- **PHP 8.1 or higher** (the `.info.yml` declares `php: 8.1`).
- The **CAPTCHA** module (`captcha`) is **recommended** for integration but is not
  a hard dependency — the module attaches its widget through its own form-alter
  logic and works without it.
- An **MTCaptcha account** with a registered domain, so you can obtain a **site
  key** and **private key**. Register at MTCaptcha's site before configuring.
- The module loads MTCaptcha's widget via its own JavaScript libraries
  (`mtcaptcha/mtcaptcha-lib-scripts`, `mtcaptcha/mtcaptcha-admin-scripts`), which
  pull client scripts from `service.mtcaptcha.com` — so the browser needs outbound
  access to MTCaptcha.

## Install with Composer

From the project root:

```bash
composer require drupal/mtcaptcha
```

Optionally add the CAPTCHA module if you want its framework as well:

```bash
composer require drupal/captcha
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mtcaptcha`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mtcaptcha -y
```

## Verify it worked

Open the MTCaptcha settings form (the module's *Configure* link on the Extend
page, or `/admin/config/development/mtcaptcha`). If the form loads with fields for
the site key and private key, you are ready to configure it — see
[Configuration](../configuration/index.md).
