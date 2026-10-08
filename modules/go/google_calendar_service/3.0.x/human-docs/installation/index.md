# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Inline Entity Form**, **Text**, **User** and **Views** modules (enabled
  automatically as dependencies).
- The **Google API PHP client** library (`google/apiclient`).
- A Google Cloud project with a **service account** and a downloaded JSON key —
  covered in [Configuration](../configuration/index.md).

## Install with Composer

From the project root, add the Google API client and the module:

```bash
composer require google/apiclient
composer require drupal/google_calendar_service -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_calendar_service -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_calendar_service -y
```

## Verify it worked

Navigate to **Configuration → Google Calendar Service → Settings**
(`/admin/config/google-calendar-service/settings`) — the settings form should load,
ready for the service‑account JSON and user email. Then continue to
[Configuration](../configuration/index.md) to connect it to Google.
