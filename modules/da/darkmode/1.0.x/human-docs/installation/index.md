# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Darkmode.js** front‑end library, installed into `web/libraries/darkmode-js`
  as an npm‑asset (steps below).

## Step 1 — Allow Composer to install npm‑asset libraries

Darkmode.js is distributed as an npm package, so your project needs to be able to
pull npm‑assets through Composer. If you haven't set this up before:

1. Add the installer‑extender package:

   ```bash
   composer require oomphinc/composer-installers-extender
   ```

2. Add the Asset Packagist repository to your project's `composer.json`
   `repositories` section (alongside the Drupal one):

   ```json
   {
     "repositories": [
       { "type": "composer", "url": "https://packages.drupal.org/8" },
       { "type": "composer", "url": "https://asset-packagist.org" }
     ]
   }
   ```

3. Under `extra`, register the npm‑asset installer type and make sure such
   libraries install into `web/libraries/{$name}`:

   ```json
   {
     "extra": {
       "installer-types": ["bower-asset", "npm-asset"],
       "installer-paths": {
         "web/libraries/{$name}": [
           "type:drupal-library",
           "type:bower-asset",
           "type:npm-asset"
         ]
       }
     }
   }
   ```

## Step 2 — Install the module and library

```bash
composer require drupal/darkmode npm-asset/darkmode-js:1.5.7
```

This installs the module and drops the Darkmode.js library into
`web/libraries/darkmode-js`, where the module expects it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/darkmode npm-asset/darkmode-js:1.5.7`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Step 3 — Enable the module

```bash
drush en darkmode -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), place the
**Darkmode Switcher** block in a region, and save. Visit the front end — a
floating toggle button should appear (bottom‑left by default) and switch the page
between light and dark when clicked. If nothing shows, confirm the Darkmode.js
library is present at `web/libraries/darkmode-js`. See the
[overview](../index.md#how-to-use-it) for the block's styling options.
