# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **PhpSpreadsheet** module (`phpspreadsheet`) — required, and used to generate the
  Excel (`.xlsx`) export.
- **Security Review 3.0.x** — this release of Security Analysis is built for it (an
  earlier 2.0.0-alpha1 of Security Analysis pairs with Security Review 2.0.x). Match
  the versions.
- To get meaningful readings, the module expects the security modules it audits to be
  present where relevant: **SecKit**, **Login Security**, **Password Policy**, and
  **CAPTCHA/reCAPTCHA**. It reports on whichever of these are installed.
- The report page pulls the **Chart.js** library from a **public CDN**, so the browser
  viewing the dashboard needs outbound internet access to render the charts.

The module provides two permissions: **access security analysis admin overview** and
**download security analysis report**. Note the project is **not covered by Drupal's
security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/security_analysis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the PhpSpreadsheet
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/security_analysis -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en security_analysis -y
```

You can also enable it from **Extend** (`/admin/modules`). Enable PhpSpreadsheet at the
same time if it is not already on.

## Verify it worked

Grant yourself **access security analysis admin overview**, then open
**`/admin/security_analysis`**. You should see the overall security rating, per-module
breakdowns, and charts. Use the download button (with **download security analysis
report**) to export the `.xlsx` workbook. Remember the tool only *reports* — it changes
no settings, so act on its findings in the respective security modules yourself.
