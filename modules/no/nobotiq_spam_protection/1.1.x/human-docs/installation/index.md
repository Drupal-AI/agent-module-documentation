# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **[Key](https://www.drupal.org/project/key)** (`key`) — used to store the
  NoBotIQ credentials securely.
- **Views** (core) and
  **[Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)**
  (`views_bulk_operations`).
- The PHP **`curl`** extension (standard on most hosts).
- **Outbound HTTPS access to `nobotiq.com`** from your server.
- A free or paid **NoBotIQ account** at nobotiq.com (3,000 free credits on
  sign-up, no card required).

Composer installs the contributed module dependencies for you with the `-W`
flag.

## Install with Composer

From the project root:

```bash
composer require drupal/nobotiq_spam_protection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Key and Views
Bulk Operations and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nobotiq_spam_protection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nobotiq_spam_protection -y
```

This enables the Key, Views, and Views Bulk Operations dependencies at the same
time.

## Verify it worked

Go to **Configuration → Web services → NoBotIQ Spam Protection**
(`/admin/config/services/spam-protection`) and confirm the settings form loads.
From there, follow [Configuration](../configuration/index.md) to add your
credentials and choose the forms to protect.
