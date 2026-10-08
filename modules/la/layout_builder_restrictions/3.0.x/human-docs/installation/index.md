# Installation

## Requirements

Layout Builder Restrictions runs on **Drupal 10 or 11** (`^10 || ^11`). Its only
dependency is core's **Layout Builder** module (`layout_builder`), which ships
with Drupal — the module simply governs what Layout Builder offers, so Layout
Builder must be enabled for it to do anything. Drush enables Layout Builder
automatically as a dependency when you enable this module.

The project also bundles an optional **Layout Builder Restrictions — By Region**
submodule (`layout_builder_restrictions_by_region`) that extends restrictions to
per-region granularity. You do not need it for basic setup; enable it separately
only if you want region-level control.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_restrictions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any related
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_restrictions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_restrictions -y
```

This also enables core's **Layout Builder** module if it is not already on. Once
enabled, the global settings appear under **Configuration → Content authoring →
Layout Builder Restrictions**
(`/admin/config/content/layout-builder-restrictions`).

## Verify it worked

Log in as an administrator and go to
`/admin/config/content/layout-builder-restrictions`. You should see the **Layout
Builder Restrictions Configuration** page listing the available restriction
plugins:

![The Layout Builder Restrictions Configuration page after installation](../images/settings.png)

If the page loads and lists the **Entity View Mode** plugin, the module is
installed correctly. Reaching this page requires the *Configure layout builder
restrictions* permission, so grant it to your admin/site-builder role if the page
is not accessible. Next, review the
[global settings and per-view-mode restrictions](../configuration/index.md).
