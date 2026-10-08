<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Timeline Styles — Views style plugins

Two style plugins are provided; both extend `StylePluginBase`, use row plugins, and support row classes and grouping.

## `timeline_styles` (Timeline Styles)
- Style option **Timeline Style Field** (`timeline_style_field`, default `timeline_styles`): the view field used as the event **title**. Remaining fields render in the event body.
- Theme hook `timeline_styles` → `templates/timeline-styles.html.twig`. `template_preprocess_timeline_styles()` builds a `nav` render array (one `views_view_field` per row for the chosen field); if the field is unset it falls back to `views_view_unformatted`.

## `timeline_styles_image` (Timeline Styles With Image)
- Adds option **`timeline_style_image`** to select the image field, alongside the title field.
- Theme hook `timeline_style_image` → `templates/timeline-styles-image.html.twig`; `template_preprocess_timeline_styles_image()` behaves like the base variant with the extra image field, falling back safely when options/fields are missing.

## Wiring a view
1. Create/edit a View of the content you want on a timeline.
2. Set **Format → Timeline Styles** (or **Timeline Styles With Image**).
3. In the style settings, pick the **title field** (and **image field** for the image variant).
4. Add the fields you want in the event body as normal Views fields.

The `timeline_styles/global-styling` CSS library is attached automatically in `hook_views_pre_render`.

## Starter config
Enabling the module installs a `timeline_styles` node type (fields: date, color via color_field, icon, image, tags → `timeline_styles_tags` vocabulary), matching view/form displays, an image style, and a demo `timeline_styles` view you can clone.
