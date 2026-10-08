# Installation

## Requirements

Colorbox Load needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Colorbox** module (`drupal/colorbox` `^2.1.1`) — the library integration that
  provides the actual lightbox.
- The **NG Lightbox** module (`drupal/ng_lightbox` `^2.1.0`) — which owns the list of
  paths that open in a lightbox and the renderer selector.

Both are declared as Composer requirements, so Composer pulls them in for you. Colorbox
itself expects the Colorbox JavaScript library to be available; follow Colorbox's own
installation notes if its status report flags a missing library.

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox_load -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies and
brings in Colorbox and NG Lightbox at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorbox_load -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox_load -y
```

Drupal enables `colorbox` and `ng_lightbox` automatically as dependencies. Enabling
Colorbox Load also sets NG Lightbox's renderer to **Colorbox** for you, so the only
thing left is to tell NG Lightbox which paths should open in the lightbox — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Media → NG Lightbox** (`/admin/config/media/ng-lightbox`) and
check that the **Renderer** select is set to **Colorbox**. Then add a path pattern (for
example `/node/*`), save, and click a matching link — the page should open in a Colorbox
overlay instead of loading normally.
