<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — theme hooks & templates

`swiper_formatter_theme()` registers three theme hooks (templates in `templates/`):

| Theme hook | Template | Key variables |
|---|---|---|
| `swiper_formatter` | `swiper-formatter.html.twig` | `id`, `swiper_title`, `content` (slides), `object` (View/Node), `settings`, `attributes`, `content_attributes`, `pagination_attributes`, `scrollbar_attributes`, `navigation_attributes` (`prev`/`next`) |
| `swiper_formatter_slide` | `swiper-formatter-slide.html.twig` | `slide`, `object`, `background`, `caption`, `slide_url`, `dialog_attributes`, `attributes`, `settings` |
| `swiper_dialog` | `swiper-dialog.html.twig` | `id`, `content`, `entity` |

## Template suggestions

The module provides rich `hook_theme_suggestions_HOOK_alter` suggestions so you can override
markup per View, display, node type, field, template, etc. For the **`swiper_formatter`** hook
(and the analogous `swiper_formatter_slide`):

- From a View: `swiper_formatter__<view_id>`, `…__<view_id>__<display>`,
  `…__<view_id>__<display>__<view_mode|field_name>`.
- From a node field: `swiper_formatter__<bundle>`, `swiper_formatter__<field_name>`,
  `swiper_formatter__<field_name>__<bundle>`, `swiper_formatter__<node_id>`, etc.
- Always: `swiper_formatter__<template_id>` (override per Swiper template).

So e.g. `swiper-formatter--hero.html.twig` targets every slider using the `hero` template,
and `swiper-formatter-slide--<field_name>.html.twig` targets a specific field's slides.

## Assets

`swiper_formatter.libraries.yml` also defines the module's own `swiper_formatter` library
(`js/swiper_formatter.js` + `css/swiper_formatter.css`, deps `core/drupal`, `core/once`) and a
`dialog` library (`css/swiper_formatter.dialog.css`). The Swiper vendor library itself is one
of `package`/`remote`/`local`/`local_minified`, chosen per template.
