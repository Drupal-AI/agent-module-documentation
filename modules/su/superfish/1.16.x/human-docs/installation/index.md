# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`lobsterr/drupal-superfish`** JavaScript library (version `2.3.11`), which
  supplies the Superfish plugin's JS and CSS. Composer installs it for you.

No contributed module dependencies or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/superfish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`lobsterr/drupal-superfish` library and update any shared dependencies as needed.
Installing via Composer is the recommended route because it places the external
library where the module expects it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/superfish -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en superfish -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region. If you see **Superfish** blocks (one per menu) in the block
picker, the module is installed and ready. Place one, configure it (see the "How to
use it" section on the [overview page](../index.md)), and load the front end to
confirm the menu renders as an animated dropdown.

If the site's status report (**Reports → Status report**) flags the Superfish
library as missing or unsupported, re-run the Composer install above so the 2.x
library lands where the module expects it, then clear the cache.
