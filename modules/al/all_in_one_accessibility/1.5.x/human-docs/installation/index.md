# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- Outbound internet access from visitors' browsers to `skynettechnologies.com`,
  since the accessibility toolbar is a hosted third‑party script loaded on every
  page.
- Optionally, a **licence token** from Skynet Technologies to unlock the paid
  widget features (the free version works without one).

There are no other Drupal module dependencies and no PHP library requirements.

> **Heads up — third‑party service.** This module injects an external script and,
> on install, POSTs your site's domain to the vendor's API
> (`ada.skynettechnologies.us`) to register it. If loading third‑party JavaScript
> or sharing your domain with an external provider is a concern for your site,
> review that before enabling.

## Install with Composer

From the project root:

```bash
composer require drupal/all_in_one_accessibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/all_in_one_accessibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en all_in_one_accessibility -y
```

## Grant the permission

Access to the settings form is controlled by the **All in One Accessibility
settings** permission ("Add ADA Tool/Script all over the site"), which is a
restricted permission. At **People → Permissions** (`/admin/people/permissions`)
grant it only to trusted administrators, since it controls a script embedded on
every page.

## Next steps

Head to [Configuration](../configuration/index.md) to enter your licence token (if
any) and set the widget's appearance. The toolbar appears site‑wide as soon as the
settings are saved.
