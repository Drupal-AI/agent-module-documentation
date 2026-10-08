# Installation

## Requirements

Media Filter is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's media handling for the media you intend to embed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_filter -y
```

## Verify it worked

Enabling the module alone does nothing visible — the filter still has to be turned
on inside a text format. Go to **Configuration → Content authoring → Text formats
and editors**, configure a format, and confirm that **Media filter** now appears
in the **Enabled filters** list. Tick it, save, and check that media embeds render
in content using that format.
