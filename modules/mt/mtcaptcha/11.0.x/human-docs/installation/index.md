# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.3** — this is a hard requirement of the module.
- The **CAPTCHA** module (`captcha`) — the standard Drupal framework for attaching
  challenges to forms, which MTCaptcha builds on. Install it alongside MTCaptcha.
- An **MTCaptcha account** with a registered domain, so you can obtain a **site
  key** and **private key**. Register at MTCaptcha's site before configuring.
- The module loads MTCaptcha's widget via its own JavaScript libraries
  (`mtcaptcha/mtcaptcha-lib-scripts`, `mtcaptcha/mtcaptcha-admin-scripts`), which
  are served from MTCaptcha — so the browser needs outbound access to MTCaptcha.

## Install with Composer

From the project root:

```bash
composer require drupal/mtcaptcha -W
```

Also require the CAPTCHA module if it is not already present:

```bash
composer require drupal/captcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mtcaptcha -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha mtcaptcha -y
```

## Verify it worked

Open the MTCaptcha settings form (the module's *Configure* link on the Extend
page). If the form loads with fields for the site key and private key, you are
ready to configure it — see [Configuration](../configuration/index.md).
