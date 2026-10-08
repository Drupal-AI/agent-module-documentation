# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No hard module dependencies, but Reader is most useful alongside a module that
  implements its API — for example
  [ActivityPub](https://www.drupal.org/project/activitypub) or the
  [IndieWeb Microsub](https://www.drupal.org/project/indieweb) endpoint — so there
  is content to read.
- The *Infinite Scroll* front-end library, loaded from a CDN by default or
  downloaded locally with `drush reader:is` (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/reader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reader -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module and theme

```bash
drush en reader -y
drush en reader_theme -y
```

The `reader_theme` submodule provides the reading display and the ability to
install the reader as a PWA on a device's home screen.

## Optional: serve Infinite Scroll locally

By default the theme loads the Infinite Scroll library from `unpkg.com`. To serve
it from your own site instead, download it into the `libraries` folder:

```bash
drush reader:is
```

## Verify it worked

Configure the reader at **Configuration → Web services → Reader**
(`/admin/config/services/reader`), then visit **`/reader`** and confirm the
reading interface loads. On a mobile device, check that you can add it to the home
screen. See the project's `README` for the complete feature list.
