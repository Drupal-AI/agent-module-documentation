# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`), including Drupal 10 and
  11.
- A running **Matomo server** you can reach over **HTTPS**, and from it three
  pieces of information:
  - an **authentication token** (`token_auth`),
  - the **site ID** for the property you want to report on (e.g. `1`), and
  - the **secure (HTTPS) URL** of the Matomo server.
- The **Matomo reporting API PHP library**, which Composer installs automatically
  with the module.

The **Matomo Analytics** module is recommended but not required — if it is present
you can reuse its configuration instead of entering the same details twice.

## Install with Composer

From the project root:

```bash
composer require drupal/matomo_reporting_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required PHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/matomo_reporting_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en matomo_reporting_api -y
```

To also install the example block that shows some Matomo statistics:

```bash
drush en matomo_reporting_api_example -y
```

## Verify it worked

Once enabled, head to [Configuration](../configuration/index.md) and enter your
Matomo server URL, site ID, and auth token. After saving, a correctly configured
connection will let the client fetch reports; the example submodule's block is the
quickest way to confirm data is coming back.
