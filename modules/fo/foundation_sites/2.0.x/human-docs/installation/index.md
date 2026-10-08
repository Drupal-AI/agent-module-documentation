# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- The **ZURB Foundation Sites** front‑end assets (and **Motion UI**, which Foundation
  needs) available to your site — either installed under `libraries/` or loaded via
  the CDN variant.

There are no other Drupal module dependencies.

## Install with Composer

This module is a little different from a typical Drupal module: the recommended
install also pulls in the Foundation front‑end assets, which live in the
**asset‑packagist** repository. Configure that repository in your root
`composer.json` first if it isn't already present:

```json
"repositories": [
    {
        "type": "composer",
        "url": "https://asset-packagist.org"
    }
]
```

Then require the module together with the Foundation assets:

```bash
composer require drupal/foundation_sites npm-asset/foundation-sites npm-asset/motion-ui
```

The maintainers recommend the **`npm-asset`** packages (not `zurb/foundation`)
because npm‑assets install cleanly into the `libraries/` folder, which is where the
module expects them. These two asset packages are declared only as *suggestions*
rather than hard Composer dependencies (a limitation of the asset‑packagist custom
repository), so you must add them explicitly as shown above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/foundation_sites npm-asset/foundation-sites npm-asset/motion-ui`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install manually (alternative)

If you'd rather not use Composer for the assets, download **Foundation Sites** from
GitHub (the module expects the *GitHub / npm* package folder structure — the download
from the foundation.zurb.com site builder is a *different* structure and is not
supported here). Unpack it so the final structure is:

```
libraries/foundation-sites/dist/...
```

Do the same for **Motion UI**, which is also required. Version 6.5.1 of Foundation
Sites is a known‑good release.

## Enable the module

```bash
drush en foundation_sites -y
```

## Verify it worked

Attach a Foundation library from a theme or test module — for example
`{{ attach_library('foundation_sites/core') }}` in a Twig template — and load the
page. Foundation's CSS/JS should now be present in the page source. If the assets
404, re‑check that the files landed under `libraries/foundation-sites/dist/` (or that
you're using the CDN variant).
