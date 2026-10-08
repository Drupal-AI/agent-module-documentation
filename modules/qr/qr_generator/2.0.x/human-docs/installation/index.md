# Installation

## Requirements

The recommended **2.0.x** branch needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or higher** (tested on PHP 8.4).
- Core **File**, **REST**, and **Serialization** modules (File and REST are listed
  dependencies; REST brings in Serialization).
- Two PHP libraries, pulled in by Composer:
  - **`endroid/qr-code`** (`^5.0 || ^6.0`) — generates the QR codes.
  - **`setasign/fpdf`** (`^1.8`) — enables PDF export.

(If your site is on an older, unsupported Drupal release, use the 1.0.x branch,
which supports Drupal 10.0+ and PHP 8.1+.)

## Install with Composer

From the project root:

```bash
composer require drupal/qr_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and brings in `endroid/qr-code` and `setasign/fpdf`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qr_generator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qr_generator -y
drush cr
```

Clearing caches after enabling is recommended so the new routes and content type
register cleanly.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep qr_generator`.
2. Go to **Content → QR Codes**, add a code, and use the **Export** action to
   download a PNG (and, if you need it, a PDF — which confirms the FPDF library is
   working). Scanning the exported code should resolve to your target.
