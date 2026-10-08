# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`) and **PHP 8.1**.
- Drupal core's **Link** module (`link`).
- The **Metatag** module (`metatag`) — install it from drupal.org if it is not
  already on your site, since the whole point of the `seo-url` token is to use it
  in your canonical metatag.

There are no third-party PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_urls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Metatag is not present yet, add it the same way:
`composer require drupal/metatag -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seo_urls -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_urls -y
```

Drupal enables Link (core) and requires Metatag as dependencies.

## Optional: SEO URLs for view pages

If you want the same clean-URL treatment for **Views** page paths, enable the
bundled submodule:

```bash
drush en seo_urls_views -y
```

## Verify it worked

Go to **`/admin/structure/seo_url`** and confirm the settings form loads and lets
you choose eligible entity types. Then check that **`/admin/content/seo_url`**
lists (and lets you add) SEO URL entities. Once you have created a mapping and
wired the token into your metatags — see [Configuration](../configuration/index.md)
— load a matching page and inspect its canonical `<link>` tag.
