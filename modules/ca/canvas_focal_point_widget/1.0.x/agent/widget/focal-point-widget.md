<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Focal point widget — mechanism, convention, and wiring

Everything this module does. It is a JavaScript enhancement of the Canvas component instance form plus one
PHP hook that ensures the JS loads. There is no config, no route, no permission, no server-side value handling.

## Install / enable

```
composer require drupal/canvas_focal_point_widget
drush en canvas_focal_point_widget
```

Requires Drupal `^11` and the **Canvas** module (`drupal/canvas:^1.0`). No configuration step.

## How the library reaches the page

- File: `src/Hook/CanvasFocalPointWidgetHooks.php`, class `CanvasFocalPointWidgetHooks`, method
  `libraryInfoAlter(array &$libraries, string $extension)` with `#[Hook('library_info_alter')]`.
- Logic: if `$extension === 'canvas'` and `$libraries['canvas-ui']` exists, it appends
  `canvas_focal_point_widget/canvas.transform.focalPoint` to `canvas-ui`'s `dependencies`.
- Why: Canvas bypasses normal page rendering and never fires `hook_page_attachments()`, so the widget must ride
  in on `canvas/canvas-ui`'s dependency chain to load before the React editor initializes.
- Library definition (`canvas_focal_point_widget.libraries.yml`): `canvas.transform.focalPoint` = 
  `js/canvas-focal-point-widget.js` + `css/canvas-focal-point-widget.css`, `dependencies: [core/drupal]`.
- Unit test `tests/src/Unit/CanvasFocalPointWidgetHooksTest.php` covers: dependency added for `canvas`,
  no change for other extensions, no failure when `canvas-ui` is absent.

## Prop naming convention (auto-discovery)

The widget attaches to nothing unless a component form exposes props with these names, per prefix:

| Prop | Required | Meaning | Range |
|------|----------|---------|-------|
| `{prefix}_focal_x` | yes | horizontal focal point % (0 = left, 100 = right) | 0–100 |
| `{prefix}_focal_y` | yes | vertical focal point % (0 = top, 100 = bottom) | 0–100 |
| `{prefix}_scale`   | no  | in-container zoom %; shows a slider when present | 100–200 |

`{prefix}` is arbitrary (e.g. `media`, `bg`, `logo`); each prefix gets its own independent picker, so one
component can carry several. Both `_focal_x` and `_focal_y` must exist or the group is skipped.

## Runtime behavior (`js/canvas-focal-point-widget.js`)

- `Drupal.behaviors.canvasFocalPointWidget.attach` scans every `form[data-form-id="component_instance_form"]`,
  regex-matches each input name against `\[([^\[\]]+)_focal_x\]` to collect prefixes, and calls
  `enhanceFocalGroup(form, prefix)` once per prefix (`seen` Set + a `.cfpw[data-prefix]` idempotency guard —
  intentionally **not** `once()`, because Canvas re-renders forms in place).
- `enhanceFocalGroup` finds the `_focal_x` / `_focal_y` / `_scale` inputs (`input[name*="[{prefix}_focal_x]"]`,
  etc.), builds the picker, inserts it before the first input's `.js-form-item` wrapper, and hides the raw
  numeric wrappers with `.cfpw-hidden` (kept in the DOM so form/React state stays intact).
- `buildPickerUI` creates DOM via `createElement` + `textContent` (no `innerHTML`): a `.cfpw` container, a
  `.cfpw__overlay` whose `background-image` is the selected media's thumbnail, a `.cfpw__dot`
  (`role="slider"`, `tabindex=0`, `aria-label="Focal point"`), an empty-state message, and — if `_scale`
  exists — a `.cfpw__scale-row` with an `<input type=range min=100 max=200>` and an `<output>` readout.
- Coordinate mapping: `getImageBounds()` reads the thumbnail's natural width/height (via a probe `new Image()`)
  and computes letterbox/pillarbox offsets so the `%` the user sets maps to the full image under
  `background-size: contain`, not just the visible box. `updateDotPosition()` / `updateFromEvent()` convert
  between pixels and `%`.
- Input handling: mouse/touch drag on the overlay, and arrow-key nudges on the dot (Shift = 10× step), both
  clamped 0–100. Every change is written back with `setNativeValue(input, value)` — it grabs the native
  `HTMLInputElement.prototype.value` setter and dispatches `input` + `change` (bubbling) so React-controlled
  inputs actually update. The scale slider mirrors the same pattern and stays in sync via a `change` listener
  on the underlying `_scale` input.
- `findMediaFieldset` locates the sibling media-library widget by `data-drupal-selector`
  (`edit-canvas-component-props-{uuid}-{prefix}` with `_`→`-`), with fallbacks to a prefix-scoped input search;
  `refreshThumbnail` re-reads `.js-media-library-item img[src]` on every call. A `MutationObserver` on the whole
  form (childList/subtree/attributes: `src`, `class`, `data-drupal-selector`) plus `refreshAllPickers()` on
  each `attach` keep the thumbnail and dot correct after Canvas AJAX swaps the media DOM node.
- `detach` (only on `trigger === 'unload'`) disconnects each picker's observer.
- Public helper: `Drupal.canvasFocalPointWidget = { setNativeValue }` for other modules to reuse.

## CSS (`css/canvas-focal-point-widget.css`)

Presentational only: `.cfpw` card, `.cfpw__thumb-area` (16:9), `.cfpw__overlay`
(`background-size: contain`), `.cfpw__dot` (20px circle, `:focus-visible` ring), `.cfpw__empty` placeholder,
and `.cfpw__scale-row` / `.cfpw__slider` / `.cfpw__scale-val`. `.cfpw-hidden { display:none !important }`
hides the raw numeric inputs.

## Wiring it into a component (author responsibility)

This module stores nothing and renders nothing — it only sets the prop values. The component's own SDC must
declare the props and its Twig must consume them. Example props (component `*.component.yml`):

```yaml
media_focal_x: { type: number, title: 'Focal Point X (%)', default: 50, minimum: 0, maximum: 100 }
media_focal_y: { type: number, title: 'Focal Point Y (%)', default: 50, minimum: 0, maximum: 100 }
media_scale:   { type: number, title: 'Image Scale (%)',   default: 100, minimum: 100, maximum: 200 }
```

Example Twig (renders the crop from the stored values):

```twig
{% set s = 'object-fit:cover;object-position:' ~ media_focal_x ~ '% ' ~ media_focal_y
   ~ '%;transform:scale(' ~ (media_scale / 100) ~ ');transform-origin:' ~ media_focal_x ~ '% ' ~ media_focal_y ~ '%' %}
<img src="{{ media.src }}" alt="{{ media.alt|default('') }}" style="{{ s }}" loading="lazy" />
```

## Operate / troubleshoot

- Picker not showing → confirm both `{prefix}_focal_x` and `{prefix}_focal_y` props exist on the component and
  the form is the `component_instance_form`; confirm `canvas/canvas-ui` loaded (the hook needs that library to
  exist). No thumbnail → a media item must be selected in the sibling media field.
- No scale slider → add a `{prefix}_scale` prop.
- Values not saving → they save as normal component props; this module only writes into the inputs, Canvas
  persists them. Check the component actually declares the number props.
