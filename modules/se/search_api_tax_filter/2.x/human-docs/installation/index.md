# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- The **Search API** module (`search_api`) — this is the only dependency, and the
  module is meaningless without it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_tax_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_tax_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_tax_filter -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**, open one of your
indexes, and switch to the **Processors** tab. The taxonomy filter processor
should now appear in the list, ready to enable and point at the terms you want to
scope indexing to. Remember to re-index after changing the processor settings.
