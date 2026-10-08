# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **Panels** (`panels`) and **Chaos Tools' Page Manager** (`page_manager`) and
  **CTools Block** (`ctools_block`) — the Panels/Page Manager stack this module
  drives. Both Panels and Page Manager are themselves in long-running beta.
- Core **Layout Discovery** (`layout_discovery`) — provides the layout plugins.

This release is a **beta** (`8.x-4.0-beta4`); plan a staging test before using it
on a live site. Composer pulls the contrib dependencies in for you when you
require the module with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/panels_everywhere -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Panels and Page Manager.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/panels_everywhere -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en panels_everywhere -y
```

Drupal enables Panels, Page Manager, CTools Block, and Layout Discovery
automatically as dependencies.

## Read the README first

Because Panels Everywhere takes the page shell away from the theme, its own
documentation stresses that **a few things must be set up properly** before it
behaves as expected — Drupal is not really designed for this kind of behavior.
Read the module's README and work through [Configuration](../configuration/index.md)
before expecting your pages to render through Panels.

## Verify it worked

Log in as an administrator and go to **Structure → Pages**
(`/admin/structure/page_manager`). You should see Page Manager's page list, into
which Panels Everywhere adds a **site template** page. Configuring that template
is the next step.
