# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- These modules enabled (Composer pulls them in for you):
  - **[Address](https://www.drupal.org/project/address)** (`address`)
  - Core **Field** (`field`)
  - **[Key](https://www.drupal.org/project/key)** (`key`) — used to hold your
    Google Maps API key securely.
- A **Google Maps API key** with the Static Maps API enabled on your Google Cloud
  account.

## Install with Composer

From the project root:

```bash
composer require drupal/address_static_map -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Address and Key modules and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_static_map -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_static_map -y
```

## Set up the Google Maps API key

The module reads the API key through the **Key** module so the secret is never
stored in plain configuration. Treat the key as a secret:

1. Store the key value in an environment variable rather than committing it. With
   DDEV: `ddev dotenv set .ddev/.env --google-maps-api-key=<value>` then
   `ddev restart` (never commit `.ddev/.env`).
2. Create a **Key** entity that reads that environment variable (Configuration →
   System → Keys, or `drush key:save`).
3. In the Address Static Map field formatter settings, point the formatter at that
   Key.

Restrict the key to your site's domain (an HTTP referrer restriction) in the
Google Cloud console, and watch your usage — Google's Static Maps service is
billed beyond a free tier.

There are no submodules. After enabling, configure the formatter on a field's
**Manage display** — see the "How to use it" section of the [overview](../index.md).
