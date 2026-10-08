# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
  Composer marks it for Drupal core `^10 || ^11`.
- The **GSAP JavaScript library, version 3.13.0**. By default the module loads
  this from the `cdn.jsdelivr.net` CDN, so no local install is strictly required
  to get started — but read the CDN note below before going to production.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gsap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gsap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gsap -y
```

## CDN vs. local delivery — decide this before production

Out of the box, all 23 GSAP library entries load from
`https://cdn.jsdelivr.net/npm/gsap@3.13.0/…`. That is the quickest way to see
animations working, but it means:

- a strict **Content‑Security‑Policy** must allow `cdn.jsdelivr.net` as a script
  source;
- the site **will not animate offline** or in an air‑gapped environment;
- **visitor IPs are exposed to jsDelivr**, which may matter for a privacy review.

To serve GSAP from your own server instead, the module ships a
`composer.libraries.json` that installs `greensock/gsap 3.13.0` locally as a
`drupal-library`. Installing it is not enough on its own, though — the shipped
`gsap.libraries.yml` still points at the CDN, so you must **override the library
definitions** (for example with `hook_library_info_alter()` in a custom module,
or a `libraries-override` entry in your theme's `*.info.yml`) to point them at the
local files.

## Verify it worked

Log in as a user with the **Administer GSAP** permission and visit **Structure →
GSAP** (`/admin/structure/gsap`). You should see the animation collection page
with an **Add** button. Create a simple animation targeting a selector on a test
page, then load that page and scroll — the element should animate into view.

Next, see [Configuration](../configuration/index.md) for the settings form and
the animation fields in detail.
