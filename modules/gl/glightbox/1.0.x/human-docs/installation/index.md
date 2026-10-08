# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- Three external **JavaScript libraries**, declared as Composer packages and installed into
  `/libraries`:
  - **GLightbox** (`levmyshkin/glightbox`) — the lightbox itself.
  - **DOM Purify** (`levmyshkin/dom_purify`) — sanitises lightbox captions.
  - **Plyr** (`levmyshkin/plyr`) — the video player used for video lightboxes.

## Install with Composer

From the project root:

```bash
composer require drupal/glightbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the three
`levmyshkin/*` library packages and update any shared dependencies. The module prefers
these locally installed libraries (under `/libraries`) over any CDN.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/glightbox -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

If the libraries don't end up under `/libraries` automatically (this depends on your
project's Composer installer‑paths setup), download GLightbox, DOM Purify, and Plyr and
place them there by hand.

## Enable the module

```bash
drush en glightbox -y
```

## Optional submodule — GLightbox Inline

To open arbitrary on‑page elements, whole pages, videos, or images in the lightbox via a
`glightbox-inline` link class, enable the bundled submodule:

```bash
drush en glightbox_inline -y
```

## Verify it worked

Set an image field to the **GLightbox** formatter on a content type's *Manage display*
(see [How to use it](../index.md#how-to-use-it) on the overview page), then view a node
with an image. Clicking the thumbnail should open the image in a lightbox popup. If it just
navigates to the image file instead, the GLightbox JS library is usually missing from
`/libraries`.
