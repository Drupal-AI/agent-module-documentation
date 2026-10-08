# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Block** module (`block`) — the only dependency, and it is enabled in a
  standard Drupal install.
- Outbound network access from your server to IPMA's public API (no credentials
  needed).

## Install with Composer

From the project root:

```bash
composer require drupal/ipma_weather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ipma_weather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ipma_weather -y
```

## Verify it worked

Go to **Structure → Block layout** and click **Place block** in any region. Search
for the IPMA weather block in the list — if it appears, the module is installed and
ready to configure. See [Configuration](../configuration/index.md) for choosing a
location and fields.
