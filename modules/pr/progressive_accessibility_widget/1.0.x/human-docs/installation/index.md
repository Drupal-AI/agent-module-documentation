# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (to place the widget).
- The external **progressive-accessibility-widget** JavaScript library
  (`>= 1.0.3`, from `github.com/progressive-digital/progressive-accessibility-widget`).
  This is **not bundled** with the module and must be installed separately — see
  "Install the widget library" below.

## Install with Composer

From the project root, install the Drupal module:

```bash
composer require drupal/progressive_accessibility_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/progressive_accessibility_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the widget library

The module expects the widget's front-end assets to live at
`/libraries/progressive-accessibility-widget/dist/`. There are two supported ways
to get them there:

- **Composer Merge Plugin** — the module ships a `composer.libraries.json`; with
  the merge plugin configured, the library is pulled in automatically when you run
  Composer.
- **Manual download** — download the library and place it under your project's
  `/libraries/progressive-accessibility-widget/` folder by hand.

The module runs a status check for this: if the widget's JavaScript file is
missing, **Reports → Status report** shows an error until the library is in place.

## Enable the module

```bash
drush en progressive_accessibility_widget -y
```

## Verify it worked

1. Visit **Reports → Status report** and confirm there is no error about a missing
   accessibility-widget JavaScript file.
2. Go to **Structure → Block layout** and confirm that **Progressive Accessibility
   Block** appears when you click **Place block**.

Then follow the [main guide](../index.md#how-to-use-it) to place the block and,
optionally, set a custom launcher icon.
