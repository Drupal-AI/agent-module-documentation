<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: template, library, CSS & JS

## Theme hook & template

`focal_point_focus_theme()` (`focal_point_focus.module:13-22`) registers hook `focal_point_focus` with a
single variable `focalpoint` (an array — see [../fields/formatter.md](../fields/formatter.md) for its
keys), template `templates/focal-point-focus.html.twig`. `template_preprocess_focal_point_focus()`
attaches the library `focal_point_focus/focuspoint` (`:30-32`).

Template structure (`focal-point-focus.html.twig`):

```
<figure class="focuspoint-wrap">
  {# scoped <style> emitted only when breakpoint CSS exists #}
  {% if focalpoint.css is not empty %}<style type="text/css" scoped>{{ focalpoint.css }}</style>{% endif %}
  <div class="focuspoint focuspoint-{{ focalpoint.field_name }}"
       data-focalpoint-breakpoints=… data-focal-provider=… data-height=…
       {# inline height only when there is no breakpoint CSS #}
       style="height:{{ focalpoint.display_height }}px"
       data-focus-x=… data-focus-y=… data-image-w=… data-image-h=…>
    <img loading=… src=… alt=… />
  </div>
  {% if focalpoint.title is not empty %}<figcaption>{{ focalpoint.title }}</figcaption>{% endif %}
</figure>
```

Override this template in your theme to change the wrapper markup. The `title` (from the image field's
title, unless muted) renders as `<figcaption>`; `alt` stays on the `<img>`. All values are emitted
through Twig autoescaping.

## Library `focal_point_focus/focuspoint` (`.libraries.yml`)

- CSS: `css/focuspoint.css` — the container is `position:relative; overflow:hidden; width:100%; height:100%`,
  and `.focuspoint img` is `position:absolute; min-width:100%; min-height:100%` with no `max-*`, so the
  image scales to fill and overflows; JS then offsets it. (This is the crop mechanism — **not**
  `object-fit`/`object-position`.)
- JS (header): `js/jQuery.focusPoint.js` — vendored jquery-focuspoint 1.1.3 (Jonathon Menz, MIT).
  `adjustFocus()` reads `data-focus-x/y` via `parseFloat`, computes `top`/`left` percentage shifts from
  container vs image size, and re-runs on window resize (throttled 17ms; behavior passes 100ms).
- JS: `js/behaviors.focusPoint.js` — `Drupal.behaviors.focusPoint` uses `once('focuspointfocusbehavior',
  '.focuspoint')`, calls `.focusPoint({throttleDuration:100}).adjustFocus()` on each. When
  `drupalSettings['focalpoint-breakpoints']` is present, binds `orientationchange resize load` to a
  handler that, per namespace, finds the matching `window.matchMedia(mediaQuery)`, sets the container
  height, and re-adjusts focus. So the scoped `@media` CSS sets height declaratively and JS mirrors it.
- Dependencies: `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`.

## Breakpoint responsive heights

When core **Breakpoint** is enabled and a Breakpoint Group is chosen in the formatter, the formatter emits
(a) a scoped `<style>` block of `@media` height rules keyed on the `.focuspoint-{namespace}` class, and
(b) `drupalSettings['focalpoint-breakpoints']` (breakpoints sorted by weight) for the JS `matchMedia`
fallback. This module is **not** a Breakpoint provider — the media queries come from whatever module/theme
defines the group. It emits a `<style>@media …` block, **not** a `<picture>`/`srcset` source.

### Test mode (visual breakpoint debugging)

A State flag adds a cycling dashed outline (20-colour wheel, `breakpointTestColors()`) around each
breakpoint output so you can see which `@media` clause is active while theming:

```php
\Drupal::state()->set('focal_point_focus.breakpoint_test', TRUE);   // enable
\Drupal::state()->delete('focal_point_focus.breakpoint_test');      // disable
```

Read in `viewElements()` (`FocalPointFocusFormatter.php:335`). Developer-only; leave it off in production.
