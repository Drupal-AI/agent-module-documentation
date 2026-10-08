# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8|^9|^10|^11`).
- The **Metatag** module (`metatag`) and its **Open Graph**
  (`metatag_open_graph`) and **Twitter Cards** (`metatag_twitter_cards`)
  submodules — SEO Studio is built as a layer on top of them.
- An **API key** for the SEO Studio preview service (an external service you
  connect on the settings form). See [Configuration](../configuration/index.md).

There are no third-party PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/seostudio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Metatag is not already on your site, add it too:
`composer require drupal/metatag -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seostudio -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seostudio -y
```

Make sure Metatag and its Open Graph and Twitter Cards submodules are enabled as
well:

```bash
drush en metatag metatag_open_graph metatag_twitter_cards -y
```

## Verify it worked

After enabling, open any node and confirm an **SEO** tab now appears next to
*Edit* and *Delete* (you can also visit `/node/{node}/seo` directly). To make the
previews work you still need to enter the API key — see
[Configuration](../configuration/index.md).
