# Installation

## Requirements

XML Sitemap 2.0.x needs **Drupal 10.3+ or 11** and the PHP **`xmlwriter`**
extension (`ext-xmlwriter`), which is part of a standard PHP install and is present
by default in DDEV. The module has no contrib module dependencies of its own.

The **Drush** command-line tool is suggested but optional — it lets you regenerate
and rebuild sitemaps from the CLI (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/xmlsitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/xmlsitemap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en xmlsitemap -y
```

Once enabled, the sitemap screens appear under **Configuration → Search and
metadata → XML Sitemap** (`/admin/config/search/xmlsitemap`), and the sitemap
itself is served at **`/sitemap.xml`**.

## Optional companion submodules

XML Sitemap ships with two submodules you can enable when you need them:

- **XML Sitemap Custom** (`xmlsitemap_custom`) — lets you hand-pick additional URLs
  to add to the sitemap that are not tied to any entity.
- **XML Sitemap Engines** (`xmlsitemap_engines`) — pings search engines (for
  example to notify them) when the sitemap is updated.

Enable whichever you need, for example:

```bash
drush en xmlsitemap_engines -y
```

You do **not** need a submodule to include ordinary content: nodes, taxonomy
terms, users, menu links and other entity types are enabled directly on the
**Sitemap Entities** tab of the main module (see
[Configuration](../configuration/index.md)).

## Verify it worked

Log in as an administrator and go to `/admin/config/search/xmlsitemap`. You should
see the **XML Sitemap** overview page with the **List**, **Settings**, **Rebuild**
and **Sitemap Entities** tabs, and a default sitemap listed:

![The XML Sitemap overview page after installation](../images/overview.png)

The sitemap is (re)generated on **cron**. After you have enabled some entity types
and let cron run — or triggered a rebuild — visit `/sitemap.xml` to confirm the
sitemap is being served. Next, review the
[configuration](../configuration/index.md).
