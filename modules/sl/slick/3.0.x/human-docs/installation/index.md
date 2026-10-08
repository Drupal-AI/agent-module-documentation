# Installation

## Requirements

Slick has a few moving parts, so plan for all three before you expect carousels
to appear:

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), including Drupal 10
  and 11.
- The **Blazy** module (`drupal/blazy: ^3.0`) — Slick uses it for lazy‑loading and
  responsive images. Composer installs it automatically as a dependency.
- The **Slick JavaScript library** itself, placed under `/libraries`. Slick works
  with either `kenwheeler/slick` (installed to `~/libraries/slick`) or the
  **Accessible Slick** fork. Two optional libraries add extras: `jquery.mousewheel`
  (mousewheel navigation) and `jquery.easing` (custom easings).

The JavaScript library is separate from the Drupal module — the module wraps it,
but does not bundle it. Until the library is present under `/libraries`, carousels
will not initialize.

## Install with Composer

From the project root:

```bash
composer require drupal/slick -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed and pull in Blazy.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slick -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slick -y
```

If you want the admin screens for managing optionsets, also enable the **Slick UI**
submodule:

```bash
drush en slick_ui -y
```

## Submodule — Slick UI

Slick ships one submodule, **Slick UI** (`slick_ui`). The base `slick` module
provides the formatters and the rendering engine; `slick_ui` adds the
point‑and‑click admin interface for creating, editing, duplicating, and deleting
optionsets at `/admin/config/media/slick`, plus the sitewide settings form. You can
run Slick without it (managing optionsets purely as exported configuration), but
most site builders enable it.

## Verify it worked

Enable Slick UI, then visit **Configuration → Media → Slick**
(`/admin/config/media/slick`). You should see the optionset collection, including
the bundled `default` optionset. Next, head to
[Configuration](../configuration/index.md) to build an optionset and apply a
carousel to a field.
