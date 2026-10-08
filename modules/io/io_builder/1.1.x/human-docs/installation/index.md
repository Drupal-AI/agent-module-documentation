# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- The **Paragraphs** module if you want the out‑of‑the‑box Paragraphs
  integration (used by the `io_builder_paragraphs` submodule) — the most common
  way to use IO Builder.

## Install with Composer

From the project root:

```bash
composer require drupal/io_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/io_builder -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module and, for Paragraphs support, the submodule:

```bash
drush en io_builder -y
drush en io_builder_paragraphs -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **IO Builder Paragraphs** | `io_builder_paragraphs` | The out‑of‑the‑box Paragraphs integration — the IO Builder paragraphs field plugin and the front‑end add/edit experience for paragraphs. Enable it if you build pages out of Paragraphs. |

## Verify it worked

After enabling, go to a content type's manage page (for example
`/admin/structure/types/manage/page`) and confirm the option to enable IO Builder
is present. Once you've enabled it on a bundle, placed the toggle block, and
exposed `{{ content.io_builder }}` in your theme (see "How to use it" on the
[overview page](../index.md)), open a page of that type as an editor — the
builder toggle should appear.
