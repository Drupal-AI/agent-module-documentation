# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Node** (`node`) module.
- The **Paragraphs** (`paragraphs`) module.
- The **GEO Starter** content model — this module reads GEO Starter's fields and
  Paragraph types. Without that content model it has nothing to emit, so it's only
  useful on a site running GEO Starter.

## Installed with the recipe (the normal path)

GEO Starter JSON-LD is **required by the GEO Starter recipe and installed
automatically with it**. If you're setting up a GEO Starter site, apply the GEO
Starter recipe as documented for that project and this module comes along with it
— you don't install it separately, and you don't need the steps below.

## Install with Composer (if you need it directly)

If you want to add the module on its own — for example to a site that already has
the GEO Starter content model — require it from the project root:

```bash
composer require drupal/geo_starter_jsonld -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geo_starter_jsonld -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geo_starter_jsonld -y
```

## Verify it worked

View the full canonical page of a **published** node that uses the GEO Starter
content model, then look at the page source for a
`<script type="application/ld+json">` block. If the structured data is present and
matches the page type (Service, Article, Answer, and so on), the module is
working. Seeing nothing on a teaser, preview, or unpublished node is expected —
that's by design.
