# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** (`taxonomy`) and **Field** (`field`) modules — Drupal enables
  these automatically as dependencies.
- The **D3 v7** JavaScript library, used for the visual grouping (icicle) interface.
  It is bundled through Composer (from `vendor/npm-asset/d3`), so there is nothing to
  fetch from an external CDN — the Composer install below brings it in.

**Recommended companions:** the core **Field UI** module (to manage fields on the
group bundles through the UI), **Views** (to list and administer groups), and
**JSON:API** or **GraphQL** if you want to expose group configuration to a decoupled
front-end.

Note this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_config_groups -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the bundled D3 library
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_config_groups -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_config_groups -y
```

## Grant the permission

Grant the **administer taxonomy term config groups** permission to the roles that
should manage grouping. Go to **People → Permissions**
(`/admin/people/permissions`) to assign it.

## Next steps

Enabling the module does not turn grouping on for any vocabulary — you do that per
vocabulary. Continue with [Configuration](../configuration/index.md).
