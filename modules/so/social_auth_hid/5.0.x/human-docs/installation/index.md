# Installation

> **Before you install:** the Humanitarian ID service was **decommissioned on 31
> January 2026**, and this module is **obsolete and unsupported**. HID login can no
> longer work, so installing this on a new site serves no purpose. These steps are
> kept for reference only.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Social Auth** module (`social_auth`), which builds on the Social API
  framework. Composer pulls this in for you.

There are no PHP extension or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_hid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Social
Auth and Social API as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_hid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_hid -y
```

## After enabling

Historically you would enter the HID client ID and secret on the module's network
settings within the Social Auth framework and place a Social Auth login block.
Because the Humanitarian ID provider has been shut down, the login flow can no
longer complete, so there is nothing further to configure on a live site today.
