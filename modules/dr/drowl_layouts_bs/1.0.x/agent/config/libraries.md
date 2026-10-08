<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries, .module hooks, permission & the overrides view

## Libraries (`drowl_layouts_bs.libraries.yml`)

All are CSS-only (built from `scss/` into `dist/css/`); none pull external JS/CSS.

| Library | CSS (dist) | Notes |
|---|---|---|
| `global` | `drowl_layouts_bs.global.min.css` | Base front-end layout styles (grid, containers, card, media object). |
| `dynamic_grid` | `drowl_layouts_bs.dynamic_grid.min.css` | Attached only for the `drowl_layouts_bs_dynamic_content_grid` layout (via `hook_preprocess_layout`). |
| `admin_preview_styles` | `drowl_layouts_bs.preview_styles.admin.min.css` | Option-preview styling. |
| `admin` | `drowl_layouts_bs.grid.admin.min.css`, `.settings.admin.min.css` | Deps: `core/drupal`, `core/jquery`, `drowl_layouts_bs/admin_preview_styles`. Backend layout UI styling. |
| `layout_paragraphs_admin` | `drowl_layouts_bs.layout_paragraphs_ui.admin.min.css` | Assumes `layout_paragraphs:^2`. Dep: `drowl_layouts_bs/admin`. |

The `global` library is declared by the layout definitions' rendering; `admin` and
`layout_paragraphs_admin` are attached by the hooks below.

## `.module` hooks (`drowl_layouts_bs.module`) — no PHP classes exist

- `drowl_layouts_bs_form_alter()` — attaches `drowl_layouts_bs/admin` +
  `/layout_paragraphs_admin` to the forms `entity_view_display_layout_builder_form`,
  `layout_builder_configure_section`, `layout_paragraphs_component_form`.
- `drowl_layouts_bs_preprocess_layout_paragraphs_builder()` — attaches the same two
  libraries to the Layout Paragraphs builder render.
- `drowl_layouts_bs_library_info_alter()` — lets the active/base theme extend the
  builder styling: if the theme defines a library named
  `drowl_layouts_bs_layout_paragraphs_additions`, it is added as a dependency of
  `layout_paragraphs_admin`. (Reads `system.theme` default + base theme via
  `library.discovery`.)
- `drowl_layouts_bs_preprocess_paragraph()` — when rendering a Layout Paragraphs
  component with regions, sets `content['regions']['#drowl_layouts_bs_force_render'] =
  TRUE` so empty regions still render in the builder.
- `drowl_layouts_bs_preprocess_layout()` — attaches `drowl_layouts_bs/dynamic_grid`
  when the layout id is `drowl_layouts_bs_dynamic_content_grid`.

## Permission (`drowl_layouts_bs.permissions.yml`)

- `access drowl_layouts_bs settings` — title "Access DROWL Layouts settings",
  `restrict access: TRUE`. **This module defines no route or form that uses it**
  (there is no `*.routing.yml`); it is declared for companion tooling/config. There is
  no settings page in this module (`configure` is null).

## Optional view (`config/optional/views.view.drowl_layout_builder_overrides.yml`)

- View id `drowl_layout_builder_overrides`, **`status: false`** (disabled by default),
  depends on `node` + `user`. Provides a page display at
  `admin/content/layout-builder-overrides` listing nodes (nid, title, langcode, type,
  operations) — intended to surface entities with per-entity Layout Builder overrides.
- Access is `type: perm` with `perm: 'configure any layout'` (a core Layout Builder
  permission). Being in `config/optional`, it is only installed if `views` is enabled
  and its dependencies are met, and must be enabled manually.

## Composer

`require`: `drupal/twig_real_content:^1`, `drupal/layout_options:^1` (core +
`layout_discovery` come via Drupal). `suggest`: `drupal/radix`, `drupal/layout_disable`.
No PHP version constraint, no third-party PHP libraries.
