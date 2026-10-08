# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- Modern browsers (Chrome 61+, Firefox 60+, Safari 11+, Edge 79+); older
  browsers fall back to standard navigation.
- **No external dependencies are required** — the module works out of the box
  using CDN delivery of the Swup.js library.

This is an early alpha release (1.0.0-alpha1); test it outside production first.

## Install with Composer

From the project root:

```bash
composer require drupal/swup -W
```

The Composer package name (`drupal/swup`) matches the module's machine name
(`swup`). The `-W` (`--with-all-dependencies`) flag lets Composer update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/swup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swup -y
```

That is all it takes for the basic experience. Visit any non-admin page — Swup
loads automatically via the CDN — and click internal links to see instant
transitions.

## Optional: the UI submodule

To configure Swup's behaviour from the admin UI, enable the bundled UI
submodule:

```bash
drush en swup_ui -y
```

This unlocks the settings form at **Configuration → User interface → Swup**
(`/admin/config/user-interface/swup/settings`), where you choose the CDN
provider, enable plugins, restrict Swup to certain themes, and adjust path
exclusions. See [Configuration](../configuration/index.md).

## Optional: install the library locally

The CDN is the quickest way to get going, but for production you may prefer to
serve Swup.js from your own site. That uses Composer's asset handling:

```bash
# Configure composer.json to allow npm assets
composer config repositories.assets composer https://asset-packagist.org
composer config extra.installer-types.0 npm-asset
composer config extra.installer-paths.web/libraries/\{\$name\} type:npm-asset

# Install the packages
composer require oomphinc/composer-installers-extender npm-asset/swup
```

Once the library is present locally, Swup uses it instead of the CDN.

## Verify it worked

Log in, visit a non-admin page, and click an internal link. The page content
should swap in smoothly without a full browser reload. Admin pages, edit forms,
and AJAX operations are deliberately excluded, so you will only see transitions
on front-end pages.
