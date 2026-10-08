# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`google/analytics-data`** PHP library (`^0.11.1`) — the GA4 Data API client
  used to talk to Google Analytics. When you install this module with Composer, the
  library is pulled in automatically.
- A **Google Analytics (GA4)** property and **API credentials** with access to its
  reporting data.
- A working **cron** on the server, so the counts refresh periodically.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_google_analytics_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and this also brings in the `google/analytics-data` library.

> If you install the module some other way (not via Composer), add the library
> manually from the **project** root (not the module folder):
> `composer require "google/analytics-data":"^0.11.1"`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_google_analytics_counter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_google_analytics_counter -y
```

Enabling the module adds the `page_views` column to `node_field_data`.

## Keep your Google credentials secret

This module authenticates to Google with a **service‑account JSON key file** — the
same file you download from the Google Cloud console. In the module's settings form
you supply that key in one of two ways: enter the **filesystem path** to the key file
on the server, or **upload** the key file through the form. The module then hands the
resolved file to the Google client via the `GOOGLE_APPLICATION_CREDENTIALS`
environment variable at request time. There is no separate API‑key or env‑var field;
the credential is always this JSON key file.

The service‑account key is sensitive — anyone who obtains it can read your Analytics
data. Treat it accordingly:

- **Never commit the key file to version control**, and never place it in a
  web‑accessible directory.
- Prefer storing the key **outside the site's public files directory** and pointing
  the *Path to Service Account Credentials Json File* setting at it, so the key is
  not served over HTTP.
- Grant the service account only the **read access it needs** to the Analytics
  property, nothing more.

## Verify it worked

Go to `/admin/config/easy_google_analytics_counter/admin` and confirm the settings
form loads. Then follow [Configuration](../configuration/index.md) to connect to
Google Analytics and start pulling in counts.
