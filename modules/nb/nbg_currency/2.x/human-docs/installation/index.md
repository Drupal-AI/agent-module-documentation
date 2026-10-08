# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). The project
  notes that its latest release targets Drupal 11.3+ and **PHP 8.3 or later**, so
  a current PHP version is recommended.
- Core's **Block** module (`block`) enabled — Drupal enables it automatically as a
  dependency.
- **Outbound HTTPS access** from your server to the National Bank of Georgia
  currency service, so the module can fetch the rates.

No API credentials, external PHP libraries, or contributed modules are required.

**Optional companions** that NBG Currency integrates with automatically when
present:

- **Tagify** — replaces the currency checkboxes with a searchable tag field on the
  block configuration form (Drupal CMS ships Tagify).
- **Drupal Canvas** — makes the NBG Currency block placeable in Canvas layouts.

## Install with Composer

From the project root:

```bash
composer require drupal/nbg_currency -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nbg_currency -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nbg_currency -y
```

## Verify it worked

Place the **NBG Currency** block (see "How to use it" in the
[overview](../index.md)), leave the default USD/EUR selection, and view the page.
You should see a table of current NBG rates in GEL with validity dates. If the
table is empty, confirm your server can reach the National Bank of Georgia service
over HTTPS.
