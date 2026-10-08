# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The core **Menu Link Content** module (`menu_link_content`) — a Drupal core
  module, enabled automatically as a dependency.

No external libraries or APIs are needed — it only requires Drupal core. It works
well alongside the **Metatag** and **Pathauto** modules for broader SEO, but
neither is required.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_sitemap_xml -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_sitemap_xml`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_xml -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

Note that despite the similar name, this is a different project from the popular
"Simple XML Sitemap" (`simple_sitemap`) module — this one requires only core and
takes its own content-type/menu-based approach.

## Enable the module

```bash
drush en simple_sitemap_xml -y
```

## Verify it worked

After enabling, go to **Configuration → Search and metadata → Simple Sitemap XML
Settings**, choose a generation mode and sources, and save. Your sitemap is then
available immediately at `/sitemap.xml`. See
[Configuration](../configuration/index.md) for the details.
