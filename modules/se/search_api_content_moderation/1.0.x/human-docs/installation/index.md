# Installation

## Requirements

Search API Content Moderation needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **Search API** (`search_api`).
- Core's **Content Moderation** module (`content_moderation`), plus the Workflows
  module it depends on and at least one moderation workflow applied to your
  content types.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_content_moderation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/search_api_content_moderation`) matches the module's machine name
(`search_api_content_moderation`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_content_moderation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_content_moderation -y
```

Enabling the module makes the Content Moderation processor available. It does
nothing on its own until you turn the processor on for an index — see
[How to use it](../index.md#how-to-use-it) in the main guide.

## Verify it worked

Edit one of your Search API indexes, open the **Processors** tab, and confirm that
**Content Moderation** now appears in the list of available processors.
