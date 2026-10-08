<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add and configure the FullCalendar Legend area

No configure route (`configure: null`). The legend is a **Views area handler** you add to a
View that already uses the FullCalendar style. Its state lives in the View config under the
display's `header` or `footer` handlers (schema `views.area.fullcalendar_legend`).

## The plugin

- `@ViewsArea("fullcalendar_legend")`, class
  `Drupal\fullcalendar_legend\Plugin\views\area\FullCalendarLegend` (extends `AreaPluginBase`).
- Registered via `fullcalendar_legend_views_data()`:
  `$data['views']['fullcalendar_legend']['area']['id'] = 'fullcalendar_legend'`.
- Option: `heading_level` — default `h3`; select of `h2` / `h3` / `h4` / `h5`. Schema enforces
  the regex `/h[2-5]/`.

## Add it (UI)

1. Edit a View whose Format is **FullCalendar** and which has bundle/taxonomy **colors**
   configured in the style options.
2. In **Header** (or **Footer**), click *Add* and choose **Fullcalendar Legend**.
3. Optionally set the **Heading level** (h2–h5). Save.

## Add it (scriptable) — into a display's footer

```php
$view = \Drupal\views\Entity\View::load('my_calendar');
$display = &$view->getDisplay('default');
$display['display_options']['footer']['fullcalendar_legend'] = [
  'id' => 'fullcalendar_legend',
  'table' => 'views',
  'field' => 'fullcalendar_legend',
  'plugin_id' => 'fullcalendar_legend',
  'heading_level' => 'h3',
];
$view->save();
```

Read back: `drush config:get views.view.my_calendar` → look for a `footer.fullcalendar_legend`
(or `header.fullcalendar_legend`) handler with `plugin_id: fullcalendar_legend`.

## How it renders (mechanism)

`render()` reads `$this->view->style_plugin->options['colors']`:

- If empty, returns `[]` (nothing shown) — so the calendar **must** have colors configured.
- For `colors.color_bundle`: a section headed by the entity's bundle label, one list item per
  bundle color.
- For `colors.color_taxonomies` (+ `colors.vocabularies`): a section headed by the vocabulary
  label, one item per term color.
- Each item sets CSS custom properties `--dot-color` and `--text-color`, and a
  `fc-display--<display>` class (`background` / `block` / …). Items are grouped by display style.
- Attaches the `fullcalendar_legend/fullcalendar_legend` CSS library and wraps everything in a
  `.fullcalendar-legend` container.

## Requirements

Enable the submodule (`drush en fullcalendar_legend -y`); it needs `fullcalendar` and core
`block`. The legend only makes sense on a View that uses the `fullcalendar` style with colors
set (see the parent module's
[configure/views-style.md](../../../../3.0.x/agent/configure/views-style.md) → the `colors`
option group).
