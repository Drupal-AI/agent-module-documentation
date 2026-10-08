# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Token](https://www.drupal.org/project/token)** module (`token`) — a hard
  dependency, used to resolve tokens in the QR text. Core's **Block** module is
  also required (it is on by default).
- Visitors' browsers must be able to reach the QR service (`api.qrserver.com`) to
  render the image.

> **Note:** this project is not covered by Drupal's security advisory policy, and
> the QR image is fetched from a third-party service by the visitor's browser — see
> the privacy note on the [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/qr_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and brings in the Token module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qr_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qr_block -y
```

This also enables Token if it is not already on.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep qr_block`.
2. Go to **Structure → Block layout**, place the **QR Block** in a region, set some
   text (try a token such as `[site:url]`), and save. Load a front-end page and
   confirm the QR image renders — scanning it should resolve to your configured
   text/URL.
