# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **countUp.js** JavaScript library (`inorganik/countup-js`, version **2.4.2** or
  newer). This is a front-end library, not a Drupal module, and it is **not** pulled
  in automatically by `composer require` of the module — you add it separately, as
  described below.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/countup_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/countup_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the countUp.js library

The module needs the countUp.js library present at
`libraries/countup.js/dist/countUp.umd.js`. There are two common ways to get it
there.

**Option A — Composer merge plugin (recommended for Composer-managed sites).** This
lets Composer download the library for you. Add a `package` repository for
`inorganik/countup-js` and enable the
[Composer Merge Plugin](https://github.com/wikimedia/composer-merge-plugin) so it
reads the module's `composer.libraries.json`:

```json
{
  "repositories": [
    { "type": "composer", "url": "https://packages.drupal.org/8" },
    {
      "type": "package",
      "package": {
        "name": "inorganik/countup-js",
        "version": "2.4.2",
        "type": "drupal-library",
        "dist": {
          "url": "https://github.com/inorganik/countUp.js/archive/refs/tags/v2.4.2.zip",
          "type": "zip"
        }
      }
    }
  ],
  "extra": {
    "merge-plugin": {
      "include": ["web/modules/contrib/*/composer.libraries.json"],
      "recurse": true
    }
  }
}
```

Then, if you don't already have it, add the merge plugin and update:

```bash
composer require 'wikimedia/composer-merge-plugin:^2.0'
composer require 'drupal/countup_formatter:^1.0'
composer update -W
```

**Option B — Manual.** Download countUp.js (version 2.4.2 or newer) from GitHub and
place it in your site's `libraries/` folder (usually `web/libraries/`), so that the
path `libraries/countup.js/dist/countUp.umd.js` exists. Then clear the Drupal cache.

## Enable the module

```bash
drush en countup_formatter -y
```

## Verify it worked

Confirm the library file is present at `libraries/countup.js/dist/countUp.umd.js`,
then follow "How to use it" in the [overview](../index.md): set a numeric field's
format to **CountUp** on *Manage display*, view a page with that field, and scroll it
into view. The number should count up as it appears. If it shows but does not
animate, the library is missing or in the wrong path.
