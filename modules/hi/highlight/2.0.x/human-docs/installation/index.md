# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

Because the highlighting runs in the browser, Highlight pairs well with search
back‑ends such as Apache Solr — you can turn off server‑side highlighting there
and let this module handle the visual emphasis client‑side.

## Install with Composer

From the project root:

```bash
composer require drupal/highlight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/highlight -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en highlight -y
```

## Verify it worked

Run an on‑site search (or arrive at a page from a search engine with query terms
in the URL). The matching keywords in the text should appear visually emphasized.
To adjust the behaviour, see [Configuration](../configuration/index.md).
