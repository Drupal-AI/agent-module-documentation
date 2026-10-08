# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). The module's
  own notes target Drupal 11/12 for its plugin architecture.
- The **Environment Context** module.

There are no third‑party PHP library requirements. This is an early release
(1.0.0‑alpha1) — pin your version and test against your target core.

## Install with Composer

From the project root:

```bash
composer require drupal/sites -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Environment
Context and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sites -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites -y
```

## Start writing your Site plugin

Sites has no configuration form — you define each site in code. To get going:

1. Enable the example submodule for annotated reference implementations:

   ```bash
   drush en sites_example -y
   ```

2. Implement your own `SitePlugin` (an annotated PHP class extending
   `SitePluginBase`) describing which content and settings belong to each site.
3. Enable any of the pattern submodules you need — path prefixes, path aliases,
   Pathauto, language negotiation, ECA integration, or the frontend preview
   switcher.

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep sites`,
then use the `sites_example` implementations as a working reference while you build
your own Site plugins.
