# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **PHP XML extension** (`php-xml`) installed on the server — the module needs
  it to run.
- For a full‑site report, a valid **`sitemap.xml`** at your site root, so the
  module can discover the pages to scan.
- No contributed module dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/page_not_found_files_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_not_found_files_reports -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_not_found_files_reports -y
```

## Verify it worked

Confirm the PHP XML extension is available (`php -m | grep -i xml`), then go to
**Reports** (`/admin/reports`) and open the Page Not Found Files report. It should
run and list any broken image URLs it finds.

> **Tip:** If the scan fails against a local or unsecured URL, try it against a
> proper HTTPS‑secured URL.
