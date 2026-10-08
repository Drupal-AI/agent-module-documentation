# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Module dependencies (Composer and Drupal pull these in):
  - **Paragraphs** (`paragraphs`) and **Layout Paragraphs** (`layout_paragraphs`,
    ^2 from 4.2 onward).
  - **Field Group** (`field_group`), **Foundation Sites** (`foundation_sites`),
    and [DROWL Layouts](../../../drowl_layouts/4.2.x/human-docs/index.md)
    (`drowl_layouts`).
  - **Twig Tweak** (`twig_tweak`), **Responsive Background Image**
    (`responsive_background_image`), and core **Breakpoint** (`breakpoint`) and
    **Field** (`field`).
- A **ZURB Foundation 6.x** based theme is expected — the module ships no CSS, so
  its options render correctly only with matching theme styles. DROWL publishes a
  companion SASS base (`drowl-sass-base` on npm) to compile the CSS in a custom
  theme.

There are no third‑party PHP library requirements from the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs,
Layout Paragraphs, DROWL Layouts, and the other dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_paragraphs -y
```

## Submodules — enable only what you need

DROWL Paragraphs ships several submodules. The base module gives you the settings
field and the settings form; the rest add ready‑made paragraph types and tooling.
Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DROWL Paragraphs Types** | `drowl_paragraphs_types` | The base set of ready‑made paragraph types. |
| **Layout Slideshow** | `drowl_paragraphs_type_layout_slideshow` | A slideshow / carousel layout paragraph (driven by the slideshow defaults on the settings form). |
| **Countdown** | `drowl_paragraphs_type_countdown` | A countdown paragraph type. |
| **Markup** | `drowl_paragraphs_type_markup` | A raw markup paragraph type. |
| **Score** | `drowl_paragraphs_type_score` | A score / rating paragraph type. |
| **Block content** | `drowl_paragraphs_type_block_content` | Embeds block content as a paragraph. |
| **Layout Restricted Access** | `drowl_paragraphs_type_layout_restricted_access` | An access‑restricted layout section paragraph. |
| **Styles UI** | `drowl_paragraphs_styles_ui` | A UI for managing paragraph styles. |

For example, to add the base types and the slideshow paragraph:

```bash
drush en drowl_paragraphs_types drowl_paragraphs_type_layout_slideshow -y
```

Each submodule requires the base DROWL Paragraphs module, which is already present
once you have installed it above.

## Verify it worked

1. Visit **Configuration → System → DROWL Paragraphs**
   (`/admin/config/system/drowl-paragraphs`) — the settings form should load (you
   need the *access drowl_paragraphs settings* permission).
2. Under **Structure → Paragraphs types**, confirm the DROWL paragraph types you
   enabled are listed, and that you can add the **DROWL Paragraph Settings** field
   to a paragraph bundle.

Next, tune the site‑wide defaults on the [Configuration](../configuration/index.md)
page.
