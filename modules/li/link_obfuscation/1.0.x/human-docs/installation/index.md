# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- No hard module dependencies are declared. The documented facet‑masking workflow
  assumes you have the **Facets** module installed and configured; install it
  separately if you want to use that integration.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_obfuscation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_obfuscation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_obfuscation -y
```

## Verify it worked

If you use the Facets integration, edit a facet at
`/admin/config/search/facets` and confirm an **Obfuscate facet link** option now
appears. After enabling it on a facet, view the search page and inspect the
markup — the facet links should be rendered as `span.drupal-masked-element`
elements rather than plain anchors. Remember to add CSS targeting that selector.
