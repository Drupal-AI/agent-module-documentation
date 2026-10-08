# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **CAPTCHA** module (`captcha`) — required; this module extends it.
- An approved **CaptchEtat habilitation** and a `client_id` / `client_secret`
  pair obtained from the PISTE administration site. Remember CaptchEtat is
  available to French public entities and State inter-ministerial partners only,
  and you must complete its authorization process **before** the service will work.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha_captchetat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If the CAPTCHA module is not already present, it will be
pulled in as a dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captcha_captchetat -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha_captchetat -y
```

## Verify it worked

Log in as an administrator and open the CaptchEtat settings form (see
[Configuration](../configuration/index.md)). Enter your `client_id` and
`client_secret`, save, then assign the CaptchEtat challenge to a test form from the
CAPTCHA module's administration pages and confirm the challenge appears.
