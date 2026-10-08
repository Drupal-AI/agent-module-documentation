# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** and **Field** modules — enabled automatically as dependencies.
- The **ZURB TwentyTwenty** JavaScript/CSS library, unpacked into your site's
  `libraries/` directory (see below). This is **not** a Composer package and is
  **not** bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/zurb_twentytwenty -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/zurb_twentytwenty -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the TwentyTwenty library

The module looks for the library at `/libraries/twentytwenty/`. Download it from
the ZURB TwentyTwenty project on GitHub and unpack it there, for example:

```bash
mkdir -p web/libraries
curl -L https://github.com/zurb/twentytwenty/archive/refs/heads/master.tar.gz | tar xz
mv twentytwenty-master web/libraries/twentytwenty
```

After this you should have these files:

- `/libraries/twentytwenty/css/twentytwenty.css`
- `/libraries/twentytwenty/js/jquery.event.move.js`
- `/libraries/twentytwenty/js/jquery.twentytwenty.js`

The module's requirements check (visible on the status report at
`admin/reports/status`) reports an error until these are present. Without them the
two images stack instead of forming a slider.

## Enable the module

```bash
drush en zurb_twentytwenty -y
```

Then go to **Manage display** for your content type, set a two‑value Image field's
format to **TwentyTwenty**, and configure it — see
[How to use it](../index.md#how-to-use-it). There is no separate configuration
page and no submodules.
