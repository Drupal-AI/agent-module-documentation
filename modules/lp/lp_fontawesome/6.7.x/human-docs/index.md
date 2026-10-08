# Libraries Provider Font Awesome — manual setup guide

**Libraries Provider Font Awesome** (`lp_fontawesome`) is a tiny module that defines
**Font Awesome** as a Drupal asset library, loaded from the jsDelivr CDN by default.
Its whole purpose is to let your themes and custom modules attach Font Awesome icons
without downloading, committing, or building the icon files themselves. There is no
admin UI, no configuration, and no code to speak of — the entire module is a single
`lp_fontawesome.libraries.yml` file.

It declares **two asset libraries**. `lp_fontawesome/fontawesome` is the CSS/webfont
build, pulling `all.min.css` for Font Awesome **6.7.2** from `cdn.jsdelivr.net`.
`lp_fontawesome/fontawesome-svg` is the SVG-with-JS build, which loads `all.min.js`
instead and is marked to replace the CSS library when you use it. Each definition
also carries `libraries_provider` metadata (its CDN source and npm package name), so
that if you *additionally* install the optional **Libraries Provider**
(`drupal/libraries_provider`) module you can pin a different version or serve the
files from the local filesystem instead of the CDN. That module is **not required** —
the definitions work out of the box straight from the CDN.

The module has **no dependencies**, no permissions, and nothing to configure — it
works the moment you enable it and attach one of its libraries. One quirk worth
knowing: the module version encodes the upstream Font Awesome version with the minor
number multiplied by ten, so module `6.7.20` corresponds to Font Awesome `6.7.2`. It
originated as the default icon set for the Drulma theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — this module has no settings page and no admin menu entry. It only exposes
asset libraries for developers and themers to attach.

## How to use it

Use it like any other Drupal asset library: attach `lp_fontawesome/fontawesome` and
then use standard Font Awesome markup such as `<i class="fa-solid fa-star"></i>`.
There are three common ways to attach it:

```twig
{# In a Twig template #}
{{ attach_library('lp_fontawesome/fontawesome') }}
<i class="fa-solid fa-star"></i>
```

```php
// In a render array or preprocess function
$build['#attached']['library'][] = 'lp_fontawesome/fontawesome';
```

```yaml
# As a dependency in your theme's or module's *.libraries.yml
my_theme_global:
  dependencies:
    - lp_fontawesome/fontawesome
```

To use the SVG + JS build instead (useful for per-icon styling or animation), attach
`lp_fontawesome/fontawesome-svg` in place of the CSS build. Attaching the library
selectively — only where icons are needed — keeps the extra request off pages that
don't use icons.

## Optional: change the version or serve locally

The library loads from the CDN with zero setup. If you need to pin a different Font
Awesome version or serve the assets from your own filesystem, install the optional
**Libraries Provider** module (`drupal/libraries_provider`). It reads the
`libraries_provider` keys already present on these library definitions. Install it
only if you need those overrides.
