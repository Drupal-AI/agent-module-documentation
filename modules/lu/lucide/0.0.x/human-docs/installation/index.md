# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`) — the Icon API
  this module plugs into arrived in Drupal 11.1.
- **PHP 8.3 or newer**.
- The **Lucide JavaScript library** installed in `/libraries/lucide/`. The
  module can download it for you (see below); the icons render client‑side from
  this library, so nothing will display until it is present.

There are no other contrib‑module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/lucide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lucide -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lucide -y
```

## Fetch the Lucide JavaScript library

The icons need the Lucide runtime on disk in `/libraries/lucide/`. The quickest
way is the bundled Drush command:

```bash
drush lucide:download
```

Alternatively, install the vendor library through Composer's
`composer.libraries.json` mechanism, or download it manually from the Lucide
project and place it in `/libraries/lucide/`.

## Verify it worked

After enabling the module and installing the library, the Lucide icons should be
selectable wherever Drupal's Icon API is offered (for example the icon picker on
a menu link or component). If a chosen icon renders as an empty box or does not
appear, the most likely cause is that the Lucide JavaScript library is missing
from `/libraries/lucide/` — re‑run `drush lucide:download` and clear caches with
`drush cr`.
