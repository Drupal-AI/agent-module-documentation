# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other module dependencies and no PHP library requirements.

The Animate.css stylesheet itself is loaded from a CDN by default, so nothing extra
is required to get started. You can optionally self-host it (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/animatecss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animatecss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animatecss -y
```

The Animate.css library is now attached to every page, and you can start adding
animation classes right away — see
[How to use it](../index.md#how-to-use-it).

## Optional: self-host the Animate.css library

By default the stylesheet is served from the Cloudflare CDN. To serve it from your
own site instead, download the library and extract it so that the file
`/libraries/animate.css/animate.min.css` exists (the archive is at
`https://github.com/animate-css/animate.css/archive/main.zip`). Once the file is in
place, the module uses the local copy automatically, and the status report will
report it as *Installed* rather than falling back to the CDN.

## Optional submodule: AnimateCSS UI

AnimateCSS ships one submodule, **AnimateCSS UI** (`animatecss_ui`), which adds an
admin interface for binding animations to CSS selectors without writing any markup.
Enable it only if you want that point-and-click workflow:

```bash
drush en animatecss_ui -y
```

Note that when the UI submodule is enabled, it takes over attaching the library
(with its richer per-selector options), so the base module stops attaching it
site-wide. See the submodule's own documentation for its configuration.
