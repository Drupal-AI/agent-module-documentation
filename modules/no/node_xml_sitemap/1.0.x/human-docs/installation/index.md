# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The contributed **XML Sitemap** module (`xmlsitemap`) — this module builds on it, and
  Composer pulls it in for you.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_xml_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the XML Sitemap module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_xml_sitemap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_xml_sitemap -y
```

Enabling Node XML Sitemap also enables the XML Sitemap module if it is not already on.

## Verify it worked

Visit `/admin/node-sitemap-listing` as an administrator — you should see the list of
valid node URLs. Then confirm the XML Sitemap module is generating your sitemap at
**Configuration → Search and metadata → XML sitemap**. See
[Configuration](../configuration/index.md) for more.
