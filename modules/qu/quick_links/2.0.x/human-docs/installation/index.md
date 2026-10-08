# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). The 2.x branch uses
  the Responsive Grid view display introduced in Drupal 10.
- Core's **Media Library** (`media_library`) and **Link** (`link`) modules.
- The **Draggable Views** (`draggableviews`) contrib module, for drag‑and‑drop
  ordering of the links. The kit also builds on an SVG image field for the link
  icons.

Composer pulls in the contrib dependencies for you when you use the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_links -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
install the module together with its dependencies (such as Draggable Views).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quick_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_links -y
```

Drupal enables the required dependencies (Media Library, Link, Draggable Views, and
the SVG image field) along with it.

## Verify it worked

After enabling, place the Quick Links block at **Structure → Block layout**
(`/admin/structure/block`) and set it to show on the home page, then open the home
page and use the settings tray to add a link. If the link appears in a grid on the
home page, the kit is working. For a styled result and automatic block placement on
Olivero, also install **Quick Links Format – Olivero**. See the "How to use it"
section of the [overview](../index.md) for the full workflow.
