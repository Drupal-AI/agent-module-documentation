<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — template, library, CSS overrides

## Theme hook & template

- Theme hook: `views_view_simple_timeline` (declared by the style plugin's `theme` key).
- Template: `templates/views-view-simple-timeline.html.twig`.
- A theme-suggestion alter (`hook_theme_suggestions_views_view_simple_timeline_alter`, via
  `SimpleTimelineHooks`) lets you add view/display-specific template suggestions, e.g.
  `views-view-simple-timeline--<view-id>.html.twig`.
- Preprocess: `hook_preprocess_views_view_simple_timeline` exposes the style options to the
  template (`SimpleTimelineHooks::preprocessViewsViewSimpleTimeline`).

## Library / CSS

- Library `simple_timeline/timeline` → `css/timeline.css` (attached automatically).
- Markup uses `ul.timeline-list` with `li.timeline-item`, an item wrapper, and
  `span.timeline-marker`.

## Common CSS overrides (put in your own theme)

```css
/* Timeline line colour */
ul.timeline-list:after {
  background-color: #555555;
}

/* Marker colour / shape */
ul.timeline-list li.timeline-item .timeline-item-wrapper span.timeline-marker {
  background: #fff;
  border: 3px solid #555555;
  border-radius: 0;
}
```

The `wrapper_class` and `class` style options let you add your own hook classes to the
wrapper and the `<ul>` so you can scope overrides per view.
