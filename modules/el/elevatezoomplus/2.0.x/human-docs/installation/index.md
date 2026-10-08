# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), including Drupal 10
  and 11.
- The **Blazy** module, version **3.x** (`drupal/blazy:^3.0`) — Composer pulls it
  in automatically, and Drupal enables it as a dependency.
- The third-party **ElevateZoom Plus** JavaScript library, self-hosted in your
  site's `/libraries` folder (see below). Without it the zoom cannot run.

## Install with Composer

From the project root:

```bash
composer require drupal/elevatezoomplus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (such as Blazy) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elevatezoomplus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the JavaScript library

ElevateZoom Plus needs the third-party `elevatezoom-plus` library on disk. Place
it under `/libraries` using either of the layouts the module detects:

- `/libraries/elevatezoom-plus/src/jquery.ez-plus.js`, or
- `/libraries/ez-plus/src/jquery.ez-plus.js` (the Composer-style layout).

Both paths are recognised automatically, so download the library and drop it in
whichever location suits your build. If the file is missing, the zoom simply
will not initialise.

## Enable the module

```bash
drush en elevatezoomplus -y
```

## Submodule — the optionset UI

The base module has **no settings screen**. To create, edit, and delete zoom
optionsets from the admin interface, enable the bundled UI submodule:

```bash
drush en elevatezoomplus_ui -y
```

That adds the optionset list at **Configuration → Media → ElevateZoom Plus**
(`/admin/config/media/elevatezoomplus`), controlled by the *administer
elevatezoomplus* permission. If you prefer to manage optionsets as configuration
(for example with `drush cget`/`cset` or config import), you can skip the
submodule and edit the `elevatezoomplus.optionset.*` config directly.
