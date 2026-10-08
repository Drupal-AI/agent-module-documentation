# Installation

## Requirements

Acquia CMS Starter is meant for an **Acquia CMS** site — it is one piece of that
distribution, not a standalone module. It needs:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- The Acquia CMS content-type modules it builds on, which Drupal enables for you
  as dependencies: **Acquia CMS Article** (`acquia_cms_article`), **Document**
  (`acquia_cms_document`), **Event** (`acquia_cms_event`), **Page**
  (`acquia_cms_page`), **Search** (`acquia_cms_search`) and **Video**
  (`acquia_cms_video`).
- Core's **Default Content** module (`default_content`), which performs the actual
  content import.
- A **configured Search API index** (Solr in the full distribution). Because
  `acquia_cms_search` is a dependency, Starter will not enable on a bare site that
  has no working search index in place — this is one of the modules that expects
  the rest of the distribution's configuration to be present.

There are no extra Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_starter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Acquia CMS modules listed above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cms_starter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_starter -y
```

Enabling it turns on its dependencies and imports the demo content. Then browse
**Content** and **Media** to see the populated site.

## Submodule

Starter ships one optional submodule, **`acquia_cms_site_studio_content`**, which
adds Site Studio demo content on top. Enable it only if your site uses Acquia's
Site Studio page builder:

```bash
drush en acquia_cms_site_studio_content -y
```

## A note on production

Starter is an evaluation and demo aid. Once you have finished looking at the
example content, uninstall the module rather than carrying its sample entities
into a live site.
