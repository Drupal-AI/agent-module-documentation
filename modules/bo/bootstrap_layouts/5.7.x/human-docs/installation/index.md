# Installation

## Requirements

Bootstrap Layouts needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`) — this is the only
  dependency, and Drupal enables it automatically when you turn on Bootstrap
  Layouts.
- A **Bootstrap‑based theme** (or any theme that provides Bootstrap's `.row` /
  `.col-*` grid classes) so the generated layouts are actually styled. This is
  not a hard Composer requirement, but without it the columns will not lay out
  side by side.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap_layouts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_layouts -y
```

That's all it takes. The Bootstrap layouts become available immediately in
Layout Builder, Display Suite, and Panels / Page Manager. There is no required
configuration and no settings form of its own.

## Submodules

Bootstrap Layouts ships **no submodules**.

## Verify it worked

Go to a layout tool — for example enable Layout Builder on a content type at
*Structure → Content types → (a type) → Manage display*, then click *Manage
layout* and *Add section*. You should see the Bootstrap layouts (one‑, two‑,
three‑, and four‑column rows, plus stacked and bricked variants) in the list.
