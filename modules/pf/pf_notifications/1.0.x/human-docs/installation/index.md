# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1** or newer.
- The following modules, which this one depends on (Composer/Drupal pull them in):
  - **Push Framework** (`push_framework`) — the notification channel framework.
  - **DANSE** with **DANSE Content** (`danse_content`) — the content‑subscription
    system whose events trigger the pushes.
  - Core **REST** (`rest`), **User** (`user`), and **Views** (`views`).
- The **Minishlink WebPush** PHP library — pulled in automatically by Composer.
- A **PWA / service‑worker‑capable setup** is recommended, since the module was
  built and tested to work with a Progressive Web App.

## Install with Composer

From the project root:

```bash
composer require drupal/pf_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches the required Push Framework, DANSE, and
WebPush library for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pf_notifications -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pf_notifications -y
```

This also enables the Push Framework, DANSE (danse_content), and the core REST /
User / Views modules if they are not already on.

## Verify it worked

Log in as an administrator and open **Configuration → System → Push framework →
Notifications** (`/admin/config/system/push_framework/pf_notifications`). The
settings form should load, ready for you to generate VAPID keys — continue with
[Configuration](../configuration/index.md).
