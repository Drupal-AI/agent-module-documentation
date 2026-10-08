# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **CAPTCHA** module (`drupal/captcha`, version 1.9.0 or newer).
- The **reCAPTCHA** module (`drupal/recaptcha`), configured with your Google
  reCAPTCHA **v2 Checkbox** keys.
- A Google reCAPTCHA **v2 Checkbox** site key and secret key (created in the Google
  reCAPTCHA admin console) — entered in the reCAPTCHA module, not here.

CAPTCHA and reCAPTCHA are hard dependencies and are installed automatically by the
Composer command below.

## Install with Composer

From the project root:

```bash
composer require drupal/recaptcha_preloader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in CAPTCHA and
reCAPTCHA and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recaptcha_preloader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recaptcha_preloader -y
```

This enables CAPTCHA and reCAPTCHA too if they aren't already on.

## Verify it worked

First confirm your CAPTCHA/reCAPTCHA setup works: enter your reCAPTCHA v2 keys and
assign a CAPTCHA challenge to a form (**Configuration → People → CAPTCHA**). Then
load that form — while the reCAPTCHA widget loads you should see the loading
placeholder and a disabled submit button, which becomes active once the real
checkbox appears.
