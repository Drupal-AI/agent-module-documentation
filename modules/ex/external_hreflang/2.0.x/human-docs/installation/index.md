# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- The **Metatag** module (`drupal/metatag:^1.0 || ^2.0`) — External Hreflang works
  entirely through Metatag's forms, so this is required. Composer pulls it in.

Optional: the **Simple XML Sitemap** module. If it's present, external hreflang
alternates are automatically added to sitemap entries — no extra configuration
needed.

## Install with Composer

From the project root:

```bash
composer require drupal/external_hreflang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Metatag and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_hreflang -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_hreflang -y
```

This also enables Metatag if it isn't already on.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`) and edit the **Global** defaults. Under the
*Advanced* group you should find a new **External Hreflang** textarea. If it's there,
the module is active — see the [main page](../index.md#how-to-use-it) for how to fill
it in. There is no separate configuration page.
