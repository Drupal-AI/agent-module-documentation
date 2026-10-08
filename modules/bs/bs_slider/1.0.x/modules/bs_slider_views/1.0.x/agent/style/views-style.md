<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Views style plugin

```bash
drush en bs_slider_views -y   # needs bs_slider + views, and a library submodule for a plugin
```

## Plugin `bs_slider_views` (BsSliderViews)

`src/Plugin/views/style/BsSliderViews.php`, `@ViewsStyle(id = "bs_slider_views", title = "BS
Slider", theme = "views_view_bs_slider", display_types = {"normal"})`, extends `StylePluginBase`.

- `usesRowPlugin = TRUE` — the view still uses a normal row plugin (fields or rendered entity);
  the style only wraps the rows in a slider.
- `defineOptions()` adds `bs_slider` (default `FALSE`).
- `buildOptionsForm()` adds a `bs_slider` select filled from
  `\Drupal::service('bs_slider_configuration.manager')->getAllOptionSet()`, empty option "- None -".

## Preprocessor (`bs_slider_views.module`)

`template_preprocess_views_view_bs_slider(&$variables)`:

1. Calls `template_preprocess_views_view_unformatted($variables)` to build `rows` the same way the
   Unformatted style does.
2. Reads the selected optionset id from the display's style options
   (`$view->getDisplay()->getOption('style')['options']['bs_slider']`); returns early if empty.
3. Loads the optionset (`manager->entityLoad()`) and its plugin (`manager->getPlugin()`), then
   calls `$plugin->view($variables['rows'], $bs_slider)` — replacing `rows` with the slider render
   array. (`BsSliderBase::view()` unwraps each row's `content` from the Views row structure.)

## Template (`views-view-bs-slider.html.twig`)

Renders an optional `<h2 class="views__title">` and then `{{ rows }}` (the slider render array).

## How to use

1. Create/choose a View, set **Format → BS Slider**.
2. In the format settings, pick an existing BS Slider optionset (e.g. a Bootstrap Carousel or
   Swiper optionset).
3. Keep a suitable **Row style** (Fields or Rendered entity) — the row content becomes each slide.

## Notes

- If no optionset is selected (or none exist), the preprocessor returns early and the view renders
  as plain unformatted rows.
- The chosen plugin (and its library) must come from an enabled library submodule.
