# Installation

Installing PhotoSwipe is two jobs: install the Drupal module, then provide the
PhotoSwipe JavaScript library it wraps.

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **PhotoSwipe 5 JavaScript library** — supplied by you (see below); the
  module's own Composer requirements are empty.
- Core's **Responsive Image** module, *only* if you want to use the **Photoswipe
  Responsive** formatter.

## Install the module with Composer

From the project root:

```bash
composer require drupal/photoswipe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/photoswipe -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en photoswipe -y
```

## Provide the PhotoSwipe JavaScript library

The library is a third‑party asset. Pick **one** of these:

### Option A — install it locally with Composer (recommended)

```bash
composer require npm-asset/photoswipe:^5
```

This places the library files under `/libraries/photoswipe/dist/…`, where the
module looks for them. (If your project is set up for it, `bower-asset/photoswipe:^5`
works too.)

### Option B — load it from a CDN

If you would rather not install the files, enable **"Load PhotoSwipe library from
CDN"** on the settings form at **Configuration → Media → PhotoSwipe**. The module
then loads PhotoSwipe from a CDN instead of `/libraries`.

Either way, check the **Status report** (**Reports → Status report**) for any
PhotoSwipe library errors after setup.

## Submodule — PhotoSwipe Dynamic Caption

The project ships one optional sub‑module, **PhotoSwipe Dynamic Caption**
(`photoswipe_dynamic_caption`), which shows captions inside the lightbox. It needs
its own JavaScript asset:

```bash
composer require npm-asset/photoswipe-dynamic-caption-plugin:^1.2
drush en photoswipe_dynamic_caption -y
```

(That asset can also be loaded via the CDN option, alongside the main library.)

## Next step

With the module enabled and the library in place, continue to
[Configuration](../configuration/index.md) to apply a formatter to a field and tune
the lightbox.
