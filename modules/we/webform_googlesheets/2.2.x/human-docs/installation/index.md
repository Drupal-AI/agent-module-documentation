# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **Webform** module, version 6.2 or newer (`drupal/webform ^6.2`).
- **Google API Client** module, version 4.5 or newer (`drupal/google_api_client ^4.5`)
  — this provides the OAuth client / service account credential entities the handler
  authenticates with.

On the Google side, before anything will send you need:

- A **Google Cloud project** with the **Google Sheets API** enabled.
- A credential created in the Google API Client module — either an **OAuth 2.0
  client** (authenticated via its callback) or a **Service Account**. Either way the
  credential must include the **Sheets** service and the
  `https://www.googleapis.com/auth/spreadsheets` scope.
- If you use a **service account**, share the target Google Sheet with the service
  account's email address (give it edit access) so it can write rows.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_googlesheets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in Webform and Google API Client if they
aren't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_googlesheets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_googlesheets -y
```

Webform and Google API Client are enabled automatically as dependencies.

## Handle credentials safely

The module writes submissions to Google using credentials you configure in Google API
Client. Treat the client secret / service-account key as a secret: store it via an
environment variable rather than committing it, and where Google API Client supports a
**Key** entity, reference the value from there. Never paste a private key into a config
file that lands in version control.

Once the module is on and a Google credential exists, add the **Google Sheets** handler
to a webform — see [Configuration](../configuration/index.md).
