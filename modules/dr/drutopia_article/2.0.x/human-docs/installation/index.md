# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- This is a Drutopia feature and pulls in a substantial dependency stack, all of
  which Composer/Drush will resolve for you:
  - **Drutopia Core** (`drutopia_core`) — the shared base feature.
  - **Drutopia SEO** (`drutopia_seo`), **Drutopia People** (`drutopia_people`)
    and **Drutopia Comment** (`drutopia_comment`).
  - Contrib: **Display Suite** (`ds`), **Facets** (`facets`), **Field Group**
    (`field_group`), **Paragraphs** (`paragraphs`), **Pathauto** (`pathauto`),
    **Metatag** (`metatag`), **Search API** (`search_api`) and **Block
    Visibility Groups** (`block_visibility_groups`).

There are no PHP library requirements. It is normally installed as part of a full
Drutopia site rather than in isolation.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_article -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in Drutopia Core and the rest of the dependency stack.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drutopia_article -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_article -y
```

Enabling it also enables its dependencies and installs the bundled configuration —
the `article` content type, its fields and displays, the `article_type`
vocabulary, the listing view, the Pathauto pattern, and the SEO/search/facet
config.

## Verify it worked

- Go to **Structure → Content types** (`/admin/structure/types`) and confirm an
  **Article** type is present.
- Go to **Content → Add content** (`/node/add`) and confirm **Article** is an
  option, then create a test article.
- Check that the article listing shows your new article and that it received an
  SEO-friendly URL alias.
