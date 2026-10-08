# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Simple XML Sitemap** module (`simple_sitemap`) — required; this module
  changes how it names and serves paginated sitemap files.

No external libraries or PHP requirements.

## Install with Composer

If you don't already have Simple XML Sitemap, Composer will pull it in as a
dependency. From the project root:

```bash
composer require drupal/simple_sitemap_pagination_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name,
`drupal/simple_sitemap_pagination_url`, matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_pagination_url -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap_pagination_url -y
```

## Verify it worked

Regenerate your sitemaps, then open `/sitemap.xml`. For a large site it should now
be a sitemap **index** that references distinct files such as `sitemap-1.xml` and
`sitemap-2.xml`, rather than query-string pages like `sitemap.xml?page=1`. That is
the form Google expects and is what clears the "nested indexing error" in Search
Console.
