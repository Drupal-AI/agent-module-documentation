# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That's it. The module has **no Composer library dependencies** and no other required
modules. Because it loads Font Awesome from the jsDelivr CDN by default, visitors'
browsers need to be able to reach `cdn.jsdelivr.net` (or you can serve the assets
locally — see below).

## Install with Composer

From the project root:

```bash
composer require drupal/lp_fontawesome -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lp_fontawesome -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lp_fontawesome -y
```

Once enabled, the two asset libraries (`lp_fontawesome/fontawesome` and
`lp_fontawesome/fontawesome-svg`) are available to attach. There is nothing to
configure.

## Optional: Libraries Provider

If you want to pin a different Font Awesome version or serve the assets from the
local filesystem instead of the CDN, also install the optional **Libraries
Provider** module — it reads the `libraries_provider` metadata already present on
these library definitions:

```bash
composer require drupal/libraries_provider -W
drush en libraries_provider -y
```

This is not required for Font Awesome to work.

## Verify it worked

Attach the library somewhere — for example add
`{{ attach_library('lp_fontawesome/fontawesome') }}` and an `<i class="fa-solid
fa-star"></i>` to a template — then load that page. The star icon should render.
There is no settings page to check; if the icon shows, the library is working.
