# Installation

## Requirements

Layout Builder Section Variations extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_section_variations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_section_variations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_section_variations -y
```

## Verify it worked

After enabling, visit **Configuration → Content authoring → Section variations**
(`/admin/config/content/layout-builder-section-variations`) and define at least one
variation. Then edit a page in Layout Builder, add or edit a section, and confirm a
new **Variation** field appears listing the variations you defined. See
[Configuration](../configuration/index.md) for details.
