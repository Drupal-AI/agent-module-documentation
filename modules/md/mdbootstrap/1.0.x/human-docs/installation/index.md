# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Bootstrap UI** module (`bootstrap_ui`) — MDBootstrap plugs into it, so it must be
  present. It is listed as a dependency.
- The **MDBootstrap library** (MDB UI Kit) — a third‑party front‑end library you add to
  your site's `libraries` directory (below). Respect MDBootstrap's license and usage terms
  for the version you use.

## Install with Composer

From the project root:

```bash
composer require drupal/mdbootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Bootstrap UI and any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mdbootstrap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the MDBootstrap library

If you load the library locally (rather than via CDN), download the MDBootstrap UI kit and
place its compiled CSS and JS in the `libraries` directory. The expected layout depends on
the MDBootstrap version:

**MDBootstrap v5** — in `/libraries/mdb-ui-kit`:

```
/libraries/mdb-ui-kit/css/mdb.min.css
/libraries/mdb-ui-kit/js/mdb.umd.min.js
```

**MDBootstrap v4** — in `/libraries/mdbootstrap`:

```
/libraries/mdbootstrap/css/mdb.min.css
/libraries/mdbootstrap/js/mdb.min.js
```

If you prefer, you can instead choose the **CDN** loading method later on the Bootstrap UI
settings page and skip the local files. See the project's `README.md` for full details.

## Enable the module

```bash
drush en mdbootstrap -y
```

## Switch Bootstrap UI to MDBootstrap

Enabling the module does not by itself change the look of your site — you have to tell
Bootstrap UI to use MDBootstrap. Go to **Administration → Configuration → Bootstrap UI**,
change the **Library** option from **Bootstrap** to **MDBootstrap**, and **Save**. See "How
to use it" in the [overview](../index.md) for the full set of loading options.

## Verify it worked

After switching the library and saving, reload a front‑end page — MDBootstrap's Material
Design styling should now be applied. If nothing changes, confirm Bootstrap UI is enabled,
that the library files are at the exact paths above (or that you selected the CDN method),
and that you saved the Bootstrap UI settings with MDBootstrap selected.
