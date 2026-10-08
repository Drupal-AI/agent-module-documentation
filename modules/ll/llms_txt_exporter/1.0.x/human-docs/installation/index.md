# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Metatag** module (`drupal/metatag`) — required for site metadata (the
  description used in the exported file).
- Optional: **Pathauto** (`drupal/pathauto`) for cleaner URLs in your content.

There are no PHP library requirements.

> **A note on security coverage:** this project is **not** currently covered by the
> Drupal security advisory policy. Weigh that when deciding where to use it.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt_exporter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Metatag and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llms_txt_exporter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llms_txt_exporter -y
```

## Verify it worked

Log in as an administrator, open **Configuration → LLMs.txt Exporter Settings**
(`/admin/config/llms-txt-exporter`), select at least one content type, and save.
Then visit `yoursite.com/llms.txt` and confirm the plain‑text summary loads with
your site name, description, and recent content.
