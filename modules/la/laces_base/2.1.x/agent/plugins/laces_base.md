<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# laces_base — layout plugins & config

## Layout plugins (`laces_base.layouts.yml`)
| Plugin id | Class | Regions | Default region |
|---|---|---|---|
| `laces_base_onecol` | `OneColumn` | first | first |
| `laces_base_twocol` | `TwoColumn` | first, second | first |
| `laces_base_threecol` | `ThreeColumn` | first, second, third | second |
| `laces_base_fourcol` | `FourColumn` | first…fourth | first |

Each plugin extends `LayoutDefault implements PluginFormInterface` and exposes a `container_type` select: `container` (Default), `container-sm/md/lg/xl/xxl`, `container-fluid`, `container-edge`. `build()` adds the container class to the section wrapper, `row` to `#row_attributes`, `col*` classes to regions, and `g-0` when `container-edge` is chosen. Templates live under `layouts/<name>/laces-base--<name>.html.twig`.

## Layout de-duplication
`laces_base_plugin_filter_layout__layout_builder_alter()` unsets `layout_onecol` (provider `layout_discovery`) and `layout_twocol_section`/`layout_threecol_section`/`layout_fourcol_section` (provider `layout_builder`) so only Laces layouts show in Layout Builder.

## Installed configuration (`config/optional/`)
Content type `laces_article_layout` (Layout Builder enabled) with body/tags/comment/`field_laces_image`; image styles `laces_xs…laces_xxl` and `hero_*`; responsive image styles `laces_full/half/quarter/tenth/twentieth/three_quarters/hero_*`; media view modes for image and remote_video at page fractions; node full/teaser view modes. `hook_install` copies bundled `laces_base.bootstrap_styles.settings` into `bootstrap_styles.settings`.
