# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **`/sitemap.xml`** endpoint. The **Simple XML Sitemap** module
  (`simple_sitemap`) is a hard dependency and provides this.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sitemap_url_checker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Simple XML
Sitemap and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sitemap_url_checker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitemap_url_checker -y
```

Enabling the module also brings in Simple XML Sitemap as its dependency.

## Verify it worked

Make sure `/sitemap.xml` returns content, then go to
**Configuration → Search and metadata → Broken URLs**
(`/admin/sitemap-urlchecker`). The checker page should load and report any URLs
that return 4xx or 5xx status codes.
