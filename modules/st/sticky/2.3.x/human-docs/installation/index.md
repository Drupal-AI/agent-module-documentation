# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- The **Sticky JS library** (`garand/sticky`, version 1.0.x), installed into your
  site's `libraries/` directory. It is **not on Packagist**, so Composer needs a
  small package definition (below), or you install it manually.
- No dependencies on other Drupal modules.
- *Suggested:* `composer/installers`, so the library lands in the right folder
  (already present in the `drupal/recommended-project` template).

## Install with Composer (recommended)

Because the Sticky library isn't on Packagist, add this package definition to the
`repositories` section of your project's **root `composer.json`**:

```json
{
  "type": "package",
  "package": {
    "name": "garand/sticky",
    "version": "1.0.4",
    "type": "drupal-library",
    "license": "MIT",
    "dist": {
      "type": "zip",
      "url": "https://github.com/garand/sticky/archive/refs/tags/1.0.4.zip"
    },
    "require": { "composer/installers": "^1.0 || ^2.0" }
  }
}
```

Make sure your root `composer.json` maps the `drupal-library` type to the
libraries directory (the recommended-project template already does this):

```json
"installer-paths": {
  "web/libraries/{$name}": ["type:drupal-library"]
}
```

Then require the module — the library is fetched into `/libraries/sticky`
alongside it:

```bash
composer require drupal/sticky
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Manual installation (alternative)

Download version 1.0.x of the Sticky library, rename the folder to `sticky`, and
place it in `/libraries/` in your Drupal root, so that
`/libraries/sticky/jquery.sticky.js` exists.

## Enable the module

```bash
drush en sticky -y
drush cr
```

## Verify it worked

1. Confirm the library file exists at `libraries/sticky/jquery.sticky.js` — if
   it's missing, the sticky behavior won't run.
2. Go to **Configuration → System → Sticky** (`/admin/config/system/sticky`) and
   confirm the settings form loads.
3. Set the DOM selector to an element you can see (the default `.menu--main`
   works on many themes), save, then scroll a long page and confirm the element
   stays pinned.

Next, see [Configuration](../configuration/index.md) to choose your target
element and fine-tune the behavior.
