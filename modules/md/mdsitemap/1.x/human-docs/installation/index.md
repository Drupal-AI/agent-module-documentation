# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No external dependencies beyond Drupal core — the module is deliberately lightweight and
  decoupled from SEO‑specific sitemap modules.

## Install with Composer

From the project root:

```bash
composer require drupal/mdsitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mdsitemap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mdsitemap -y
```

## Verify it worked

Go to **Configuration → Search and metadata → MD Sitemap**
(`/admin/config/search/md-sitemap`) to confirm the settings page loads. Once you have
chosen which entity types and bundles to include (see
[Configuration](../configuration/index.md)), visit **`/sitemap-llm`** to see the generated
LLM sitemap with your configured URL suffix.
