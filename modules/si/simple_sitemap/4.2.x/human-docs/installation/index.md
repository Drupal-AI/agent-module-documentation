# Installation

## Requirements

Simple XML Sitemap 4.2.x runs on **Drupal 10.3+ or 11** and has no contrib module
dependencies. The only technical requirement is the PHP **XMLWriter** extension
(`ext-xmlwriter`), which is bundled with virtually every standard PHP install, so
in practice there is nothing extra to add.

The module ships two optional submodules you can enable later if you need them:

- **Search engine settings** (`simple_sitemap_engines`) — submits your sitemap to
  search engines and supports the IndexNow / sitemap ping protocols.
- **Views integration** (`simple_sitemap_views`) — lets you add Views‑provided
  pages and routes to a sitemap.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update anything it needs to
in order to satisfy the requirement.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap -y
```

To enable a submodule as well, name it explicitly, for example:

```bash
drush en simple_sitemap_engines -y
```

## Where the sitemap is served

Once the module is enabled and a sitemap has been generated, the default sitemap is
served at:

```
/sitemap.xml
```

Each named variant also has its own path at `/{variant-name}/sitemap.xml`. Straight
after installation the sitemap exists but contains no content URLs — you have to
enable at least one entity type first (see
[Choosing which content is included](../choosing-content/index.md)) and regenerate.

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata → Simple
XML Sitemap** (`/admin/config/search/simplesitemap`). You should land on the
**Status** screen showing a **Default** sitemap of type *Default hreflang*:

![The Simple XML Sitemap status screen after installation](../images/status.png)

If that page loads and lists the Default sitemap, the module is installed
correctly. Next, review the [configuration](../configuration/index.md), then
[choose which content to include](../choosing-content/index.md).
