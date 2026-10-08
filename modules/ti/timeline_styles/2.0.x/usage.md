<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Timeline Styles provides Views style plugins that render a view's rows as a chronological, event-based timeline, plus an image-capable variant and a prebuilt "Timeline Styles" content type, vocabulary and view to get started quickly.

---

The module registers two Views style plugins: **Timeline Styles** (`timeline_styles`) and **Timeline Styles With Image** (`timeline_styles_image`). Each uses row plugins, supports row CSS classes and grouping, and adds one option to the style form — a select for which view field is used as the event title (and, in the image variant, the image field); the remaining fields render as the event body. Theming is done through `timeline_style` / `timeline_style_image` theme hooks and templates, with `template_preprocess_timeline_styles()` assembling a `nav` render array from the chosen field per row and a `timeline_styles/global-styling` CSS library attached on `views_pre_render`. On install the module ships config for a `timeline_styles` node type with fields for date, color, icon, image and tags (a `timeline_styles_tags` vocabulary), matching displays/view modes, an image style, and a `timeline_styles` view demonstrating the style. It depends on `color_field` and `color_picker` for the per-event colour field.

Operationally this is a front-end display module: it adds no routes, no permissions, no controllers and no forms beyond the Views style options form, so there is no anonymous, mutating or external surface. Field values are rendered through Views' own field handlers and standard theming (no raw markup sinks in the plugins), so escaping follows core Views/Twig. Setup: `composer require drupal/timeline_styles` (with `color_field`/`color_picker`), enable it, then either use the bundled `timeline_styles` content type + view, or set any view's Format to "Timeline Styles" and choose the title field in the style settings.

---
- Display a view's results as a vertical event timeline
- Choose the "Timeline Styles" format on any view
- Pick which field is the event title in the style options
- Use the image-enabled "Timeline Styles With Image" format
- Select the image field for the image timeline variant
- Use the bundled `timeline_styles` content type out of the box
- Create timeline events with date, color, icon, image and tags fields
- Tag events with the `timeline_styles_tags` vocabulary
- Set a per-event color via the color_field/color_picker widget
- Use the shipped `timeline_styles` demo view as a starting point
- Apply row CSS classes to timeline entries
- Group timeline rows with Views grouping
- Render events with any entity/field data exposed to Views
- Build a company/history/roadmap timeline page
- Theme the timeline via `timeline-styles.html.twig` templates
- Attach the module's global styling automatically on render
- Switch an existing list view into a timeline layout
- Show a media/image beside each timeline event
