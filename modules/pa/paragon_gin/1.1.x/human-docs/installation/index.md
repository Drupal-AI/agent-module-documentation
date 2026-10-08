# Installation

## Requirements

Paragon Gin coordinates several other modules, so it has more dependencies than a
typical add‑on. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Paragon Core** (`paragon_core`) — the shared Paragon base module.
- **Gin LB** (`gin_lb`) — Gin styling for Layout Builder.
- **Layout Builder Browser** (`layout_builder_browser`) — the block library used in
  Layout Builder.
- Core's **Navigation** (`navigation`) and **Navigation Top Bar**
  (`navigation_top_bar`) modules.

You will also want the **Gin** admin theme installed and set as your
administration theme, since Paragon Gin's refinements target it.

## Install with Composer

From the project root:

```bash
composer require drupal/paragon_gin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragon Core, Gin
LB, Layout Builder Browser and the other dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragon_gin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragon_gin -y
```

Drupal will enable the required dependencies (Paragon Core, Gin LB, Layout Builder
Browser and the core Navigation modules) along with it.

## Verify it worked

With the Gin admin theme active, edit any entity that uses **Layout Builder**. You
should see Paragon Gin's touches: restyled section edit links, a tooltip showing
the block type when you hover over a block, and a cleaner navigation top bar with
Layout Builder and version‑history shortcuts. Open **Appearance → Settings → Gin**
to find the Layout Builder block view‑mode toggle Paragon Gin adds there.
