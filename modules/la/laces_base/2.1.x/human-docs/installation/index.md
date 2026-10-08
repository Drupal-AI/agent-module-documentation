# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- These **core modules**, all enabled automatically as dependencies: Node,
  Breakpoint, Layout Builder, Layout Discovery, Media, Media Library, and
  Responsive Image.
- The **Laces theme** — necessary for several of this module's features to render
  correctly. Install it alongside the module.
- The companion contrib modules the layouts and styles are built on:
  **Bootstrap Layout Builder**, **Bootstrap Styles**, **Layout Builder Blocks**,
  **Crop**, **Image Effects**, and **Focal Point**. Install these so the provided
  configuration and image handling work end to end.

## Install with Composer

Installing with Composer is recommended, because it pulls in the module together
with its dependencies. From the project root:

```bash
composer require drupal/laces_base -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add the companion projects (for example the Laces theme and
Bootstrap Layout Builder) with further `composer require` commands if they aren't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/laces_base -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en laces_base -y
```

Enabling the module runs its install step, which imports the article content type,
image styles, media and responsive‑image view modes, breakpoints, and layouts, and
seeds the Bootstrap Styles settings.

## Verify it worked

- In **Structure → Content types** you should see **Article with Layout**.
- Editing that content type's layout, the layout picker should offer the Laces
  one/two/three/four column layouts (and *not* the duplicate core ones).
- Make sure the **Laces theme** is installed and active so the layouts and styles
  render as intended.
