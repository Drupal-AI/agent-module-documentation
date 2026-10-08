# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **Colorbox** module (`drupal/colorbox`) — a hard dependency. Colorbox
  provides the lightbox library and the global settings this module builds on, so
  it must be installed, enabled, and have its front-end library available.

There are no other third-party Composer or PHP library requirements for this
module itself. (Colorbox has its own JavaScript library setup — follow Colorbox's
own installation instructions to make sure its library is in place.)

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox_simple_load -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Colorbox
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/colorbox_simple_load -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox_simple_load -y
```

Colorbox is enabled automatically as a dependency if it isn't already on. Make
sure Colorbox's own library is installed and working (test any existing Colorbox
feature) — this module relies on it.

## Verify it worked

Add a link with the `colorbox-load` class somewhere it will render to the browser,
e.g. in a block body:

```html
<a class="colorbox-load" href="/node/1">View in lightbox</a>
```

Load the page and click the link — it should open in a Colorbox overlay rather
than navigating away. If it navigates normally instead, check that Colorbox and its
JavaScript library are installed and that the class reached the final markup
(text-format filtering can strip attributes). See the
[overview](../index.md#how-to-use-it) for per-link URL options.
