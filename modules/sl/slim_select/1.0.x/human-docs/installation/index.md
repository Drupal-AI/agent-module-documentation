# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No dependent Drupal modules.
- The external **Slim Select** JavaScript library (from
  [slimselectjs.com](https://slimselectjs.com)) — this must be present for the
  enhanced selects to work.

## Install with Composer

From the project root:

```bash
composer require drupal/slim_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slim_select -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Provide the Slim Select library

The module does not bundle the JavaScript library itself; you supply it. There
are two ways:

- **Preferred (npm).** The module ships a `package.json` that pulls in the
  `slim-select` library. With Node.js/NPM installed, run `npm install` from the
  module's folder (for example `web/modules/contrib/slim_select`). To keep it in
  sync automatically, add a `post-install-cmd` script to your project's
  `composer.json` that runs `npm install -C web/modules/contrib/slim_select`
  after each `composer install` (adjust the path to match your layout).

- **Manual.** Download the library and place it in a `libraries` folder in your
  webroot (or profile/site directory) so the file resolves at
  `libraries/slim-select/dist/slimselect.min.js`.

## Enable the module

```bash
drush en slim_select -y
```

Once the module is enabled and the library is present, any form element that
carries a `#slim_select` property renders as an enhanced, searchable select —
see the main guide's "How to use it" section.
