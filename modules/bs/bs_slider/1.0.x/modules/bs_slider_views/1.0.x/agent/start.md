<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Views (bs_slider_views) — agent index

Integration submodule of **BS Slider**. Adds a Views **style** plugin that renders rows through a
BS Slider optionset. Package `Media`. Depends on **`bs_slider`** and core **`views`**. Core
`^9.2 || ^10 | ^11`. No permissions. Version 1.0.0-alpha8.

- **The style plugin, its option and preprocessor** → [style/views-style.md](style/views-style.md)

## What it provides (from source)

- Views style plugin **`bs_slider_views`** ("BS Slider"),
  `src/Plugin/views/style/BsSliderViews.php` (extends `StylePluginBase`, `usesRowPlugin = TRUE`,
  `theme = "views_view_bs_slider"`). One option `bs_slider` (select of optionsets via
  `manager->getAllOptionSet()`, empty option "- None -").
- `bs_slider_views.module` → `template_preprocess_views_view_bs_slider()`: reuses
  `template_preprocess_views_view_unformatted()`, reads the selected optionset from the display
  style options, loads it + its plugin, and calls `$plugin->view($variables['rows'], $bs_slider)`.
- Template `templates/views-view-bs-slider.html.twig` (renders optional title + `{{ rows }}`).
- No config schema, routes, permissions or services of its own.

Parent framework → [../../../../agent/start.md](../../../../agent/start.md).
