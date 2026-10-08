<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — the `reading_time` template

- Theme hook: `reading_time` (declared by `node_read_time_theme()`).
- Template: `templates/reading-time.html.twig` — ships as literally `{{ reading_time }}`.
- Variables: `reading_time` (the formatted string, e.g. "3 minutes") and `template`
  (default `reading-time`).

Override it in your theme by copying `reading-time.html.twig` and wrapping the value, e.g.:

```twig
{# themes/mytheme/templates/reading-time.html.twig #}
<span class="reading-time">🕑 {{ reading_time }} read</span>
```

In a node template you can also print the extra field directly:

```twig
{{ content.reading_time }}
```

The value is produced by the render element added in `node_read_time_node_view()` when the
`reading_time` extra field is enabled on the node's Manage display and the node type is
activated in `node_read_time.settings`.
