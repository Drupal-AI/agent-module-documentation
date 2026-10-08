# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module and its oEmbed support, with at least one oEmbed‑backed
  media type in use (this is how remote video/media reaches your pages in the
  first place). The module lists no explicit module dependency of its own.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_oembed_provider_markup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_oembed_provider_markup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_oembed_provider_markup -y
```

Enabling the module alone changes nothing on the page. You must switch on its
option in a field's display settings for it to take effect — see "How to use it"
in the [overview](../index.md).

## Verify it worked

Edit the **Manage display** of an entity that renders an oEmbed field, open the
oEmbed field's formatter settings, and confirm the **Use provider's markup for
oEmbed field** option is available. Enable it, save, then view a page with an
embed: the media should render from the provider's own markup rather than being
wrapped in Drupal's `/media/oembed` proxy iframe (you can confirm this by
inspecting the page — the outer `/media/oembed` iframe should be gone).
