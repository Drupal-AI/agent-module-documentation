# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **Media** (`media`) and **Editor** (`editor`) modules.
- The **ACE Editor** module (`ace_editor`) and the `ace-builds` JavaScript
  library — this is the part that needs the extra Composer setup below.

## Prepare Composer for the ACE library

The ACE code‑editor library is distributed as an npm asset, so your project's
root `composer.json` must be told where to find asset packages and where to place
them before you require the module. If your project was created recently these
settings may already be present — check first, and only add what is missing.

1. Make sure **Asset Packagist** is listed as a repository alongside the Drupal
   package repository:

   ```json
   "repositories": {
     "drupal": {
       "type": "composer",
       "url": "https://packages.drupal.org/8"
     },
     "assets": {
       "type": "composer",
       "url": "https://asset-packagist.org"
     }
   }
   ```

2. Add an installer path so the ACE library lands in `web/libraries/ace`, and
   allow bower/npm asset types in the generic libraries path:

   ```json
   "installer-paths": {
     "web/core": ["type:drupal-core"],
     "web/libraries/ace": ["npm-asset/ace-builds"],
     "web/libraries/{$name}": [
       "type:drupal-library",
       "type:bower-asset",
       "type:npm-asset"
     ]
   }
   ```

3. Declare the asset installer types and the Drupal library mapping:

   ```json
   "installer-types": ["bower-asset", "npm-asset"],
   "drupal-libraries": {
     "library-directory": "web/libraries",
     "libraries": [
       {"name": "ace", "package": "npm-asset/ace-builds"}
     ]
   }
   ```

## Install with Composer

With the repositories and installer paths in place, require the module:

```bash
composer require drupal/gherkin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the ACE Editor
module and the `ace-builds` asset (placed into `web/libraries/ace`) and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gherkin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gherkin -y
```

## Verify it worked

Go to **Structure → Media types** and confirm a **Gherkin** media type is listed,
then visit **Content → Media → Add media → Gherkin** and check that the script
field opens in the ACE code editor. If the editor loads with syntax highlighting,
the ACE library was installed correctly.
