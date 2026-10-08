# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Shortcode** module (`shortcode`) — this is the required dependency that
  provides the shortcode filter framework Shortcode SVG plugs into.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/shortcode_svg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in the Shortcode module if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shortcode_svg -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shortcode_svg -y
```

Drupal will enable the Shortcode module automatically as a dependency.

## Verify it worked

Make sure the Shortcode filter is enabled on the text format you author in
(**Configuration → Content authoring → Text formats and editors**). Then upload an
SVG sprite and try the `[svg …]` shortcode in a piece of content — the referenced
icon should render as a vector image.
