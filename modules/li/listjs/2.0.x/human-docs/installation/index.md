# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **List.js** JavaScript library — this module provides the Drupal
  integration, but the library itself must be present on your server (see below).

There are no PHP library requirements.

## Install the module with Composer

From the project root:

```bash
composer require drupal/listjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/listjs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the List.js JavaScript library

The module needs the third‑party List.js library. The recommended way is to let
Composer manage it as a Bower asset:

```bash
composer require bower-asset/listjs
```

This requires your project to be set up to install third‑party front‑end
libraries via Composer (a configured `installer-paths` entry and the
`oomphinc/composer-installers-extender` plugin — see the Drupal.org guide on using
Composer for front‑end libraries).

**Manual alternative:** download the List.js library, extract it, and place the
`listjs` directory inside your site's `libraries` directory
(`libraries/listjs/…`).

## Enable the module

```bash
drush en listjs -y
```

## Enable the Views submodule (optional)

To add fast client‑side search to a Views list, also enable **List.js Views**:

```bash
drush en listjs_views -y
```

You then configure the behavior on the individual View display at **Structure →
Views**.

## Verify it worked

Confirm the library is discoverable — for instance with Drupal's Status report or
by checking that `libraries/listjs` (manual install) or the Composer‑installed
asset path exists. Then attach the `listjs` library to a page (via the theme
function or the Views submodule) and confirm typing in the search input filters
the list instantly without a page reload.
