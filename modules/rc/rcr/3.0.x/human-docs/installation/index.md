# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Block** module (`block`) — enabled by default; the module provides its
  rates block through it.
- Outbound network access from the server to the national-bank feeds, so the rate
  fetch (and cron / `drush rcr-getrates`) can reach them.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rcr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rcr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rcr -y
```

## Verify it worked

1. Visit **Configuration → System → Currency settings**
   (`/admin/config/system/currency-settings`) and confirm the settings form
   loads. Choose a country and save.
2. Fetch the first set of rates:

   ```bash
   drush rcr-getrates
   ```

3. Place the **RCR** block at **Structure → Block layout** and view a page — the
   current USD/EUR values should appear in the block's region.

See the [overview](../index.md) for the full setup and usage walkthrough.
