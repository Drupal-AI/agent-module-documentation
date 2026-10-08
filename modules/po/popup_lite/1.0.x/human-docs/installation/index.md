# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** (`system`) module — part of Drupal core.
- The **iziModal** JavaScript library, which powers the modal display. If it is not bundled
  automatically, follow the module's project page for how to place the library where Drupal's
  libraries system can find it.

To attach media (images, audio, video) to popups you will also want core's **Media** and
**Media Library** modules enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/popup_lite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/popup_lite -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en popup_lite -y
```

## Submodules

Popup Lite ships an optional **Popup Lite Extended** (`popup_lite_ext`) submodule that adds
extended features. Enable it only if you need those extras:

```bash
drush en popup_lite_ext -y
```

## Verify it worked

Go to **`/admin/content/popup-lite`**, click **Add Popup**, create a simple `on_load` popup
with some body text, and save it. Visit a front‑end page that matches the popup's visibility
paths — the iziModal dialog should appear after any configured delay, with a working close
button.
