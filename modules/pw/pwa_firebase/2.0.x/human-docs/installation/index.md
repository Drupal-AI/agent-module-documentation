# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Firebase project** with **Cloud Messaging** enabled — you will download a
  **service account key JSON** file from it (see
  [Configuration](../configuration/index.md)).
- Installing with Composer pulls in Google's `google/auth` library automatically,
  which the HTTP v1 API needs.
- Your site must be served over **HTTPS** — browsers only allow service workers and
  web push on secure origins.

## Install with Composer

From the project root:

```bash
composer require drupal/pwa_firebase -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies and brings in `google/auth`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pwa_firebase -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pwa_firebase -y
```

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pwa_firebase`.
2. Visit `/manifest.json` and `/firebase-messaging-sw.js` on your site — both
   should be served.
3. Continue to [Configuration](../configuration/index.md) to connect your Firebase
   project before notifications will actually send.
