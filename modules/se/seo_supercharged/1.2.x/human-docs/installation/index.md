# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`) and
  **PHP 8.1+**.
- Drupal core modules **Node, File, Image, Media, User, System, Path, Path alias,
  and Taxonomy** — all ship with core, and Drupal enables them as dependencies.
- **Recommended:** the **Metatag** module, so the module can write SEO title,
  description, canonical URL, and Open Graph tags per node.
- **Optional:** the **Paragraphs** module — if your article body field is a
  Paragraphs entity reference rather than a plain text field, the module
  auto-detects this and creates the paragraph entity for you.

No additional third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_supercharged -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add Metatag the same way if you want SEO tags written:
`composer require drupal/metatag -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seo_supercharged -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_supercharged -y
```

Enabling the module creates a **media type called `seo_supercharged`**, which is
where pushed images are stored.

## Prepare your article content type

Before the platform can publish into Drupal, get one content type ready (see the
project README for the full checklist):

- **Body field:** either a plain `text_with_summary` field or a Paragraphs
  reference — both are auto-detected.
- **Featured image:** an entity reference to media, using the `seo_supercharged`
  media bundle created on install.
- **Optional:** a gallery image field, taxonomy fields for categories and tags,
  and a Metatag field.

## Verify it worked

Go to **Configuration → Content authoring → SEO Supercharged**
(`/admin/config/content/seo-supercharged`) and confirm the settings form loads.
The next step is to set the API key and map your fields — see
[Configuration](../configuration/index.md).
