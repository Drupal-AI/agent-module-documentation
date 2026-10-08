# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal ships and enables by default.
- **The Simple Icons SVG library**, extracted into `libraries/simple-icons`. This is
  a real prerequisite — the module reads the icon SVGs from that directory, so it
  will not render icons until the library is present.

There are no other third‑party Composer packages or PHP libraries.

## Install the Simple Icons library

The module needs the contents of the Simple Icons repository in
`libraries/simple-icons`. The maintainer's preferred way is via Asset Packagist —
once your project is configured to use it, run:

```bash
composer require npm-asset/simple-icons
```

To confirm the library landed in the right place, run this from your Drupal
webroot; it should print SVG markup:

```bash
cat libraries/simple-icons/icons/drupal.svg
```

If that command returns SVG, the library is correctly installed.

## Install the module with Composer

From the project root:

```bash
composer require drupal/simple_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_icons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_icons -y
```

## Verify it worked

Once the library is in `libraries/simple-icons` and the module is enabled, you will
have a **Simple Icons icon** field type and formatter available in the Field UI, plus
the `simple_icons_icon()` Twig function. There is no configuration form to visit —
add an icon field to a content type, or call the Twig function in a template, and the
icons should render as inline SVG.
