# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **[JSON:API Extras](https://www.drupal.org/project/jsonapi_extras)** `^3` — pulled
  in automatically by Composer as a required dependency.
- Core's **Path alias** (`path_alias`) and **Content Moderation**
  (`content_moderation`) modules. Content Moderation is what powers the editor
  "Open Gatsby Preview" button, so it is needed for the preview workflow.
- A running **GatsbyJS front-end** (using `gatsby-source-drupal` for JSON:API, or
  `gatsby-source-graphql`) with preview and/or build webhook URLs you can point
  Drupal at.

## Install with Composer

From the project root:

```bash
composer require drupal/gatsby -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in JSON:API Extras
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gatsby -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gatsby -y
```

## Submodules

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Gatsby Extras** | `gatsby_extras` | Enhances JSON:API so Drupal menus and their aliased links are exposed to Gatsby. Enable it if your Gatsby site needs menu data. |
| **Gatsby Fastbuilds** | `gatsby_fastbuilds` | A hidden legacy stub — its incremental-sync behavior is now built into the main module. You do not need to enable it. |
| **Gatsby Instant Preview** | `gatsby_instantpreview` | A hidden legacy stub, replaced by the built-in Fastbuilds/preview handling. You do not need to enable it. |

To add the menu/link enhancer:

```bash
drush en gatsby_extras -y
```

## Secrets: webhook URLs and build tokens

Your Gatsby preview and build webhook URLs can contain secrets (for example a Gatsby
Cloud build token embedded in the URL). Rather than committing those into exported
config, set them per environment. Store the value in an environment variable — with
DDEV, `ddev dotenv set .ddev/.env --gatsby-build-webhook=<url>` then `ddev restart` —
and override the config from `settings.php`, for example:

```php
$config['gatsby.settings']['incrementalbuild_url'] = getenv('GATSBY_BUILD_WEBHOOK');
$config['gatsby.settings']['preview_callback_url']  = getenv('GATSBY_PREVIEW_WEBHOOK');
```

Once installed, continue to [Configuration](../configuration/index.md) to fill in
the settings form.
