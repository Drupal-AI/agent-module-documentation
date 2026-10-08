<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `scale_popover` component + the popover-alter hook

## The Single Directory Component

`views_color_scales:scale_popover` lives in `components/scale_popover/`:

- `scale_popover.component.yml` — declares slots **`display_value`** (the pre-rendered cell value)
  and **`content`** (the popover body render array), and props `has_popover` (bool),
  `value` (number), `bg_color` (string), `text_color` (string), `popover_id` (string).
  `libraryOverrides.dependencies`: `core/drupal`, `core/once`.
- `scale_popover.twig` — renders:
  ```twig
  <span class="vcs-value"
        {% if has_popover %}tabindex="0" data-vcs-popover="{{ popover_id }}"
          aria-describedby="{{ popover_id }}" title="{{ 'Value: @value'|t({'@value': value}) }}"{% endif %}
        style="--vcs-bg: {{ bg_color }}; --vcs-fg: {{ text_color }};">{% block display_value %}{% endblock %}</span>
  {% if has_popover %}
  <div id="{{ popover_id }}" class="vcs-popover" popover role="tooltip">{% block content %}{% endblock %}</div>
  {% endif %}
  ```
  `bg_color` is always the `#RRGGBB` produced by `calculateColor()` and `text_color` is
  `black`/`white`, both set as CSS custom properties `--vcs-bg` / `--vcs-fg`.
- `scale_popover.css` — styles `.vcs-value` (inline-block chip, `background: var(--vcs-bg)`,
  `color: var(--vcs-fg)`) and `.vcs-popover` (a fixed, `popover`-API tooltip; hidden until
  `:popover-open`; dark-mode + Gin variants).
- `scale_popover.js` — `Drupal.behaviors.vcsScalePopover` uses `core/once` on
  `[data-vcs-popover]`; on `mouseenter`/`focusin`/`click` it calls the native
  `popover.showPopover()` and positions it relative to the trigger (viewport-clamped, flips above
  when there is not enough room below); hides on `mouseleave`/`focusout`. If the browser lacks
  `showPopover`, it no-ops (the value still shows, just no popover).

The popover markup is only emitted when a module has supplied content via the hook below
(`has_popover`); a plain colored value has no popover div.

## `hook_views_color_scale_popover_alter(array &$content, array $context)`

Declared in `views_color_scales.api.php`. `NumericColorScale::render()` calls
`$this->getModuleHandler()->alter('views_color_scale_popover', $popover_content, $context)` before
building the component. Implement it to inject **any render array** into the popover body.

`$context` keys:

- `value` (float) — raw numeric value.
- `display_value` (Markup|string) — the formatted value shown in the cell (`parent::render()`).
- `min` / `max` (float) — the gauge range (from the **manual** `color_scale_min`/`max`).
- `position` (float) — normalized 0–1 position of the value within `[min, max]` (4 dp).
- `field_options` (array) — all Views field handler options.
- `view` (`ViewExecutable`) — the executing view.
- `row` (`ResultRow`) — the current result row.

Example (from the API file): render a custom gauge only for one view's base table.

```php
function mymodule_views_color_scale_popover_alter(array &$content, array $context): void {
  if ($context['view']->storage->get('base_table') !== 'my_module_results') {
    return;
  }
  $content = [
    '#theme' => 'my_module_gauge',
    '#value' => $context['position'],
    '#display_value' => $context['display_value'],
    '#range_min' => $context['min'],
    '#range_max' => $context['max'],
  ];
}
```

Whatever you put in `$content` is placed in the component's `content` slot and rendered through
Drupal's normal render pipeline, so it is escaped/sanitized like any render array.
