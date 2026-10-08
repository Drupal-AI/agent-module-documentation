# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`).
- The **Twig Tweak** module (`twig_tweak`).
- **Drupal Canvas** — only if you want the Canvas features (dragging the component
  onto a Canvas page and the contextual‑edit pencil). The SDC‑as‑paragraph and Twig
  usage work without Canvas.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_sdc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and Twig
Tweak and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_sdc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the dependencies and the module, then rebuild the cache:

```bash
drush en paragraphs twig_tweak -y
drush en paragraph_sdc -y
drush cr
```

## Verify it worked

If you use **Drupal Canvas**, open the Canvas editor on a page and look under
"Other" in the component library — you should find **Paragraph SDC**. Drag it in,
set the entity type to *paragraph*, the view mode to *full*, and enter a paragraph
ID; the content should render. Without Canvas, confirm that an **SDC** paragraph
type is available to add to a paragraph field.
