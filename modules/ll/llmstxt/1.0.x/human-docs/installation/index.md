# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules or third‑party libraries are required — the module has no
  dependencies.

Bear in mind this is a **1.0.0-alpha1** release, so test it on a non‑production
environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/llmstxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llmstxt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llmstxt -y
```

## Verify it worked

Go to **Configuration → Search and metadata → llms.txt**
(`/admin/config/search/llmstxt`) and enter some content, then visit
`https://yoursite.com/llms.txt` in a browser — you should see exactly what you
saved. See [Configuration](../configuration/index.md) for the details of the
form.
