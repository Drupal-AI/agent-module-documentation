# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Views** module (`views`) — the module registers a Views style plugin,
  so Views must be enabled.
- The **Macy.js** JavaScript library (v2.5.1). By default it is loaded from the
  jsDelivr CDN, so no manual download is required for a standard install; see the
  note below about self‑hosting.

There are no third‑party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/macyjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/macyjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en macyjs -y
```

Views is enabled in a standard Drupal install; if it is not, Drupal enables it as
a dependency.

## Self‑hosting the library (optional)

By default the Macy.js library is fetched from the jsDelivr CDN at page load. If
your site has a strict Content Security Policy or needs to work offline, download
the Macy.js 2.5.1 asset, place it in your site's `/libraries` (or theme), and
point the module's library definition at that local file instead of the CDN URL.

## Verify it worked

Create or edit a **View**, open the display's **Format** setting, and confirm that
**Macy.js** appears as a choice. Selecting it and saving, then loading the view,
should render the rows as a multi‑column masonry grid. If items overlap while
images load, enable **`waitForImages`** in the format settings.
