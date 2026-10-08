# Installation

Installing Masonry API is two steps: install the module with Composer, then put
the two third-party JavaScript libraries on disk. The second step is easy to
forget and is the usual reason "no grid appears" — the module attaches its layout
code, but the browser gets 404s for the actual library files.

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Two JavaScript libraries that are **not bundled** with the module and must be
  added separately (see below):

  | Library | Expected path (relative to your docroot) | Version |
  |---------|------------------------------------------|---------|
  | Masonry | `/libraries/masonry/dist/masonry.pkgd.min.js` | 4.2.2 |
  | imagesLoaded | `/libraries/imagesloaded/imagesloaded.pkgd.min.js` | 5.0.0 |

Both come from DeSandro: <https://masonry.desandro.com/> and
<https://imagesloaded.desandro.com/>.

## Install with Composer

From the project root:

```bash
composer require drupal/masonry -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masonry -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masonry -y
```

## Install the JavaScript libraries (required)

You have a few options; only the resulting file paths matter.

### Option A — Composer with the merge plugin

The module ships a `composer.libraries.json` that declares both libraries as
`drupal-library` packages. Wire it into your root `composer.json`:

```bash
composer require wikimedia/composer-merge-plugin
```

then in the **root** `composer.json`:

```json
"extra": {
  "merge-plugin": {
    "include": ["web/modules/contrib/masonry/composer.libraries.json"]
  }
}
```

(adjust the path for your docroot), then run `composer update`. The packages
install into `/libraries/masonry` and `/libraries/imagesloaded`.

### Option B — Manual download

Download each package from the DeSandro sites above and unpack them so the two
files listed in the [requirements table](#requirements) exist.

### Non-default locations

The module resolves the libraries through core's library-directory finder and
the contrib **Libraries** module as well as the plain `libraries/` path, so
site-specific or profile library directories work too — it rewrites the paths
automatically when it finds them elsewhere.

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). The module adds two
checks — **Masonry library** and **ImagesLoaded library** — which show an error
with the expected path when a file is missing, and disappear once both are
present.

## Next steps

Masonry API has no configuration page of its own. To actually produce a grid,
either configure a consuming module (such as *Masonry Views*) or call the
`masonry.service` from your own code — see the [main guide](../index.md#how-to-use-it).
