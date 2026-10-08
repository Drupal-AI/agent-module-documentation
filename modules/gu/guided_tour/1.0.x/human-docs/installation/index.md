# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (enabled on every site).
- The **Driver.js** JavaScript library, **v1.4.x** (MIT licensed). It is installed
  automatically via Composer into `/libraries/driver.js/`.

Note: this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/guided_tour -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This also pulls in the Driver.js library, provided your
project's `composer.json` is set up to install `drupal-library` packages into
`/libraries` (the standard Drupal recommended‑project layout).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/guided_tour -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en guided_tour -y
```

## Verify it worked

Go to **Administration → Configuration → User interface → Guided Tour** and click
**Add tour**. If the tour form loads, the module is installed and Driver.js is in
place. Create a small tour with one step, then visit the targeted page and confirm
the tooltip appears.

If tours don't render, check that `/libraries/driver.js/` exists — a missing
library is the most common cause.
