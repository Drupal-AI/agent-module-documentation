# Installation

## Requirements

Cookie Consent Notice by CookieYes needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **CookieYes account** (external SaaS) to obtain the consent‑management script
  snippet. The module only loads that script — it does not provide the banner
  itself.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_consent_notice_by_cookieyes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cookie_consent_notice_by_cookieyes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_consent_notice_by_cookieyes -y
```

## Grant the permission

The module defines one restricted permission, **`cookieyes_scripts_settings`**,
which is required to reach the settings form. Grant it only to trusted
administrator roles.

Next, add your CookieYes snippet and turn the banner on — see
[Configuration](../configuration/index.md). Note that in the 3.0.x release the
settings page may error due to a shipped defect; the Configuration guide shows how
to set the values with Drush instead.
