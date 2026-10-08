# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Paragraphs** module and core field modules it depends on: **Field**,
  **Link**, **Options**, **Taxonomy**, **Telephone** and **Text**. The base
  component library deliberately keeps to plain field modules so it carries no
  heavy runtime of its own.
- **On Drupal 11.4 and later, `telephone` is the *contrib* Telephone module** —
  core removed Telephone from Drupal 11.4, so Composer will pull in
  `drupal/telephone` as a dependency. This is expected.
- Best installed as part of a **LocalGov Drupal** site. On bare Drupal core,
  enabling this module can fail because its submodules require further LocalGov
  dependencies (`localgov_core` and the wider paragraphs stack) — enable those
  first, or install the LocalGov distribution.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
Paragraphs, the core field modules, and (on Drupal 11.4+) the contrib Telephone
module alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_paragraphs -y
```

## Submodules — enable what you need

| Submodule | What it adds |
|-----------|--------------|
| `localgov_paragraphs_layout` | Layout Paragraphs support so components can be arranged in multi‑column sections. |
| `localgov_paragraphs_views` | Lets a view be embedded on a page as a component. |
| `localgov_homepage_paragraphs` | The component set a council homepage needs. |
| `localgov_subsites_paragraphs` | The richer component set used by subsite pages — required by `localgov_directories_promo_page`. |

For example:

```bash
drush en localgov_paragraphs_layout -y
```

## Verify it worked

Go to **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`). You
should see the LocalGov components — **Text**, **Image**, **Link**, **Contact** and
**Numbered text**. Then, on a content type with a Paragraphs field, confirm you can
add these blocks while editing content.
