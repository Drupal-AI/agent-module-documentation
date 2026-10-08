# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10`).
- Drupal core only — no other modules, no PHP library, and no third‑party
  Composer requirements.

Optional companions for real spam protection, which pair well with Delay Submit:
[Honeypot](https://www.drupal.org/project/honeypot),
[CAPTCHA / reCAPTCHA](https://www.drupal.org/project/captcha).

## Install with Composer

From the project root:

```bash
composer require drupal/delay_submit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/delay_submit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en delay_submit -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → People → Delay Submit**
(`/admin/config/people/delay-submit`). If the settings form loads, the module is
active. Nothing changes on any form until you add form IDs on that page — see
[Configuration](../configuration/index.md).
