# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`) — a hard dependency, used to store the Flickr API
  credentials securely. Composer installs it automatically with the command below.
- A **Flickr API application key** from Flickr. See Flickr's developer site for how
  to request one.

## Install with Composer

From the project root:

```bash
composer require drupal/flickr_integration_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `key`
dependency and any shared libraries alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flickr_integration_suite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first — it provides the Flickr API connection:

```bash
drush en flickr_integration_suite -y
```

## Submodules — enable only the placement you use

The display methods are split into submodules so you carry only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Block** | `flickr_integration_suite_block` | A configurable block type for displaying Flickr Photosets and Galleries. Best for site builders placing photos in a region. |
| **Field** | `flickr_integration_suite_field` | A configurable field type for displaying Flickr Photosets and Galleries. Best for a content model. |
| **Filter** | `flickr_integration_suite_filter` | A text-format filter for embedding Flickr photos inline in editable content. Best for editors writing prose. |
| **Filter (Colorbox)** | `flickr_integration_suite_filter_colorbox` | Extends the filter with a Colorbox lightbox display. |

Enable the one(s) you want, for example the block:

```bash
drush en flickr_integration_suite_block -y
```

## Verify it worked

Go to **Configuration → System → Flickr Integration Suite**. If the API settings
form loads and lets you select a Key for your Flickr credentials, the base module
is installed correctly. Next, follow [Configuration](../configuration/index.md) to
store your API key and start displaying photos.
