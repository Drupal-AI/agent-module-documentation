# Block content suggestions — manual setup guide

**Block content suggestions** (`block_content_suggestions`) makes content blocks
themeable per instance, per bundle, and per view mode by adding the Twig template
suggestions that Drupal core deliberately leaves out. Out of the box, core renders
content blocks (`block_content` entities) without a dedicated theme hook, so a
themer cannot easily override an individual custom block. This module fills that
gap so you can style a specific block, a whole block type, or a particular view
mode with a normal template override.

Once enabled, it registers a `block-content.html.twig` template and emits a cascade
of template suggestions — from the most specific (a single block by ID and view
mode) down to the general base template. Drupal then uses the most specific
template file you have created, exactly as it does for nodes. There is no
configuration, no permissions, no services, and no admin UI: enabling the module is
all that is required, and you do the rest in your theme by adding suitably named
Twig files.

The available template names follow familiar patterns — by view mode, by block
type (bundle), by bundle and view mode together, by block ID, and by block ID and
view mode together — so you can target styling as broadly or as narrowly as you
need. Inside your template you get the block entity, the current view mode, and the
rendered field content to work with.

This guide is written for a **human** (here, mostly a themer) working through the
theme layer. If you want terse, token‑cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page. Once enabled, the template suggestions are
available and you work entirely in your theme's Twig files.

## How to use it

After enabling the module, create a Twig template in your theme named for the block
you want to style, and clear the cache so Drupal picks it up
(`drush cache:rebuild`). Drupal will use the most specific matching file. The
available names, from least to most specific, are:

| Template file | Targets |
|---|---|
| `block-content.html.twig` | the base wrapper for all content blocks |
| `block-content--{view-mode}.html.twig` | all content blocks in a view mode (e.g. `--teaser`, `--full`) |
| `block-content--{bundle}.html.twig` | all blocks of a type (e.g. `--hero`, `--basic`) |
| `block-content--{bundle}--{view-mode}.html.twig` | a block type in a given view mode |
| `block-content--{id}.html.twig` | one specific block by its numeric ID (e.g. `--5`) |
| `block-content--{id}--{view-mode}.html.twig` | one specific block in a given view mode |

Inside the template you have these variables to work with:

- **`content`** — the render array of the block's fields. Print everything with
  `{{ content }}`, a single field with `{{ content.field_example }}`, or all but
  one with `{{ content|without('field_example') }}`.
- **`block_content`** — the block entity itself, so you can call getters like
  `{{ block_content.label }}`.
- **`view_mode`** — the current view mode (e.g. `full`, `teaser`).

You can further extend or reorder the generated suggestions with the standard
`hook_theme_suggestions_block_content_alter()` in a theme or module.
