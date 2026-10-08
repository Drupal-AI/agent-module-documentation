# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- The **CAPTCHA** module (`captcha`) — required. This module uses CAPTCHA's default
  challenge settings, so make sure CAPTCHA is enabled and configured with a
  challenge type you are happy with.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha_protected_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The CAPTCHA module is pulled in as a dependency if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captcha_protected_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha captcha_protected_page -y
```

## Verify it worked

Add a test path in the settings (see [Configuration](../configuration/index.md)),
then visit that path as an anonymous user in a private browser window. You should be
redirected to the verification page and shown a CAPTCHA; after passing it you land
on the original page, and a verification cookie keeps you from being re-challenged
until it expires.
