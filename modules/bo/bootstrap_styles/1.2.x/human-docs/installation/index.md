# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — Bootstrap Styles is a
  styling engine for Layout Builder, so this is required. Drupal enables it as a
  dependency.
- The **Media Library Form Element** module
  (`drupal/media_library_form_element`, `^2.0`) — used for the background
  image/video media picker. Composer pulls this in.

To get the actual editing experience you'll also want a consumer module such as
**Bootstrap Layout Builder** (`drupal/bootstrap_layout_builder`), which surfaces
the style controls in the Layout Builder UI. Bootstrap Styles works as a
foundation on its own but adds no visible controls without one.

Scroll‑in animations use the **AOS** JavaScript library. It loads remotely by
default, or locally if you place it in `libraries/aos`.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Media Library
Form Element and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_styles -y
```

Enabling it also turns on Layout Builder and Media Library Form Element if they
aren't already active. Bootstrap Styles ships **no submodules**.

## Verify it worked

Go to **Configuration → Content authoring → Bootstrap Styles**
(`/admin/config/bootstrap-styles/settings`) and confirm the settings form loads.
Remember that the styling controls themselves only appear in Layout Builder once
you install a consumer module like Bootstrap Layout Builder. See
[Configuration](../configuration/index.md) for the settings.
