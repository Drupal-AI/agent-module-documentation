# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Image** (`image`) modules, which Drupal
  enables as dependencies.
- The third‑party **OwlCarousel2** JavaScript library (version 2.3.4). This is
  **not** shipped with the module — you install it separately (see *Add the
  OwlCarousel2 library* below). Until it is present, carousels will not render.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/owlcarousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/owlcarousel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en owlcarousel -y
```

## Add the OwlCarousel2 library

The module needs the OwlCarousel2 JavaScript library at
`/libraries/owlcarousel2/dist/owl.carousel.js`. The quickest way is the bundled
Drush command, which downloads the 2.3.4 release, extracts it, and places it in
your `/libraries` folder for you:

```bash
drush owlcarousel:download
```

The command has the alias `oc:dl`. (A legacy `drush owlcarousel-plugin [path]`
command is still present for older setups.)

To install it by hand instead:

1. Download the OwlCarousel2 2.3.4 release from
   <https://github.com/OwlCarousel2/OwlCarousel2>.
2. Rename the extracted folder to `owlcarousel2`.
3. Place it under `/libraries` so that
   `/libraries/owlcarousel2/dist/owl.carousel.js` exists.

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). The module adds an
**owlcarousel2 library** check that reads *Installed* when the library is in
place, or errors with a download link when it is missing. Once it reads
*Installed*, set up a carousel from a field display or a view as described in the
[overview](../index.md).
