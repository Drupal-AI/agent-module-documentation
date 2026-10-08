# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`; the module also targets the
  upcoming Drupal 12).
- Core **Taxonomy** and **Node** (you filter node listings by taxonomy terms);
  no contributed modules are required by the base module.
- Vocabularies whose terms have **URL aliases**, since the facet URLs are built
  from term aliases.

There are no extra PHP libraries to install, and — by design — no JavaScript,
search backend, or database search index.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_facets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_facets -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_facets -y
```

## Submodules — enable only what you need

Taxonomy Facets ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **URL Export** | `taxonomy_facets_export` | Exports the set of generated facet URLs. |
| **Tome Static export** | `taxonomy_facets_tome` | Works with the Tome module to freeze the faceted site to static HTML that still filters when served from a plain web server or CDN. Requires the Tome module. |
| **XML Sitemap** | `taxonomy_facets_simple_sitemap` | Works with the Simple XML Sitemap module to publish the facet URLs in your sitemap. Requires the Simple XML Sitemap module. |

For example, to add static export with Tome:

```bash
drush en taxonomy_facets_tome -y
```

## Verify it worked

After enabling and doing the basic configuration (see
[Configuration](../configuration/index.md)), visit the browse base path (default
`/browse`). You should see a listing, and placing a facet menu block should give
you clickable term links whose URLs read as term‑alias trails such as
`/browse/europe/italian`.
