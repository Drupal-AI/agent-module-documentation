# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`) — the foundation this kit configures.
- The **Field Group** module (`field_group`) — used to group the bundles' fields.
- Core's **Image**, **Options**, and **Text** modules (`image`, `options`,
  `text`), which are part of a standard Drupal install.

Paragraphs and Field Group are contrib modules, so Composer will fetch them as
dependencies. There are no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/oomph_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs, Field
Group, and any other shared dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/oomph_paragraphs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oomph_paragraphs -y
```

Enabling it imports the paragraph‑bundle configuration (fields, form displays, and
view displays) and registers a Twig template for each bundle. Drupal will enable
Paragraphs, Field Group, and the core dependencies automatically if they are not
already on.

## Verify it worked

Go to **Structure → Paragraph types** and confirm the imported bundles are listed
— Row, Column group, Hero, WYSIWYG, Image, Video, Accordion, and Testimonial. Then
add a Paragraphs reference field to a content type and confirm you can add those
bundles when editing a node. Remember to add a video field to the **Video** bundle
if you intend to use it (see [How to use it](../index.md#how-to-use-it)).
