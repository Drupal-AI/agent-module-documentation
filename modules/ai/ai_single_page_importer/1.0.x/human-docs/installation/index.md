# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Node** module (`node`) — enabled by default on standard sites.
- The **AI** module (`ai`) with a configured **AI provider** and its API key
  stored as a secret (a Key entity or an environment variable). Composer pulls
  the AI module in as a dependency.

There are no additional third-party PHP library requirements. The current
release is an alpha (`1.0.0-alpha4`), so test before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_single_page_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the AI module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_single_page_importer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_single_page_importer -y
```

## After enabling

1. Make sure the **AI** module has a provider configured under
   **Configuration → AI** (`/admin/config/ai`), with the API key stored as a
   secret.
2. Grant permissions carefully. Give **`use ai single page importer`** only to
   trusted editors — they choose the URL your server will fetch — and
   **`administer ai single page importer settings`** to administrators who set
   up the field mappings.
3. Remember that each import fetches an external URL server-side and sends the
   page content to the AI provider (an external, billable call). Import only
   from trusted sources.
