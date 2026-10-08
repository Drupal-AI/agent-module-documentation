# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`).
- The **Metatag** module (`metatag`) — install it from drupal.org if it is not
  already on your site. The content types you want to use SEO AI on must have a
  Metatag field.
- Access to an **OpenAI-compatible chat completions endpoint** and an API token
  for it. This is an external service you supply on the configuration form; the
  module does not include one.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Metatag is not yet present, add it the same way:
`composer require drupal/metatag -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seo_ai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_ai -y
```

Drupal will pull in Node (core) automatically. Make sure Metatag is enabled too
(`drush en metatag -y`).

## Verify it worked

Go to **Configuration → Search and metadata → SEO AI**
(`/admin/config/content/seo-ai`) and confirm the settings form loads. After you
fill it in (see [Configuration](../configuration/index.md)) and enable at least
one content type, edit a node of that type — the **Generate Metatags** button
should appear on the form.
