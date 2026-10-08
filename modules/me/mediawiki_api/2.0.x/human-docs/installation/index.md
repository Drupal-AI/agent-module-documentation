# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contrib module dependencies and no PHP library requirements — MediaWiki API
  relies only on Drupal core.
- Access from your Drupal server to an existing **MediaWiki** instance's API
  endpoint (`api.php`). The module renders wiki syntax by calling that API, so the
  wiki must be reachable over the network from Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/mediawiki_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mediawiki_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mediawiki_api -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a text format. In the list of available
filters you should now see the **MediaWiki** filter. Enable it, set your wiki's API
URL (see "How to use it" on the [overview page](../index.md)), then enter some
MediaWiki syntax in a field using that format and confirm it renders as HTML.
