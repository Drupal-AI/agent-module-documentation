# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- The **CAPTCHA** module (`drupal/captcha`) — CAPTCHA After builds on it and
  cannot work without it.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha_after -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including the CAPTCHA module if it is not already present).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/captcha_after -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha_after -y
```

Enabling it pulls in the CAPTCHA module as a dependency if it is not already on.
Next, set the attempt threshold and review the security points — see
[Configuration](../configuration/index.md).
