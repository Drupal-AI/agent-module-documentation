# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **CAPTCHA** module (`captcha`), which provides the challenge framework this
  module plugs into. Composer installs it automatically as a dependency.
- The **`tencentcloud/captcha` PHP package** (version `^3.0`), pulled in
  automatically by Composer.
- An account on the **Tencent Cloud Captcha Console**, from which you obtain the
  credentials described in [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/tencentcloud_captcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what brings in the CAPTCHA module and the
`tencentcloud/captcha` package. The Composer package name
(`drupal/tencentcloud_captcha`) matches the module's machine name
(`tencentcloud_captcha`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tencentcloud_captcha -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tencentcloud_captcha -y
```

Enabling the module does not protect any form yet — continue to
[Configuration](../configuration/index.md) to enter your Tencent credentials and
select the forms to guard.
