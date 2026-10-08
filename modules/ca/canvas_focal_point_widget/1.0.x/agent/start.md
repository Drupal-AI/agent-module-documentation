<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Focal Point Widget (canvas_focal_point_widget) — agent index

A **client-side focal-point picker + scale slider** for image props of **Canvas** (Experience Builder)
components. Package `Canvas`. Depends on `canvas` (`drupal/canvas:^1.0`). Core `^11`. License
GPL-2.0-or-later. Version 1.0.0-alpha1 (dir `1.0.x`). Maintainer-flagged work-in-progress / AI-assisted.

- **How the widget works, the prop naming convention, the hook, and how to wire it into a component** →
  [widget/focal-point-widget.md](widget/focal-point-widget.md)

## What it actually is

- **All behavior is in JavaScript** — `js/canvas-focal-point-widget.js`, `Drupal.behaviors.canvasFocalPointWidget`.
  It enhances any `form[data-form-id="component_instance_form"]` that contains inputs named
  `canvas_component_props[UUID][{prefix}_focal_x]…` / `…[{prefix}_focal_y]…` (and optional `…[{prefix}_scale]…`).
- **One PHP hook**, no more: `CanvasFocalPointWidgetHooks::libraryInfoAlter()`
  (`src/Hook/CanvasFocalPointWidgetHooks.php`, `#[Hook('library_info_alter')]`) appends the widget library to
  `canvas/canvas-ui`'s dependencies so it loads before the React editor (Canvas skips
  `hook_page_attachments()`). The `.module` file is empty aside from the file docblock.
- **Library** `canvas_focal_point_widget/canvas.transform.focalPoint` (`*.libraries.yml`): the one JS + one CSS
  file, depends on `core/drupal`.
- **No routes, no permissions, no services, no plugins, no config, no config schema, no Drush, no install file,
  no submodules.** Values are stored by Canvas as ordinary component prop numbers; this module never touches
  them server-side.

## Auto-discovery convention (from source)

- On each `attach`, the behavior scans every input, matches `\[([^\[\]]+)_focal_x\]` to derive a `prefix`, and
  calls `enhanceFocalGroup(form, prefix)` once per prefix (idempotency guard: skip if
  `.cfpw[data-prefix="…"]` already exists). Requires both `{prefix}_focal_x` and `{prefix}_focal_y`;
  `{prefix}_scale` is optional and, when present, adds a 100–200 % range slider.
- The picker (`buildPickerUI`) overlays a draggable/keyboard dot (`role=slider`, arrow keys; Shift = 10× step)
  on a thumbnail read from the sibling media-library fieldset (`findMediaFieldset`), computing letterbox offsets
  from the image's natural size so `%` coordinates map to the whole image. It hides the raw numeric wrappers
  (`.cfpw-hidden`) but leaves them in the DOM, and writes back via `setNativeValue()` (native input setter +
  dispatched `input`/`change`) so React/Drupal form state updates.
- Deliberately does **not** use `once()`; a `MutationObserver` on the form plus the re-attach cycle keep the
  picker alive across Canvas AJAX re-renders. `detach` (on `unload`) disconnects observers.
- Exposes `Drupal.canvasFocalPointWidget.setNativeValue` for reuse by other modules.

## The consuming side is the component author's job

- This module renders **no output**. The component's own Single Directory Component YAML must declare the props
  (`{prefix}_focal_x`, `{prefix}_focal_y`, optional `{prefix}_scale` as `number`), and its Twig must apply them,
  e.g. `object-position: {focal_x}% {focal_y}%` and `transform: scale(...)`. See
  [widget/focal-point-widget.md](widget/focal-point-widget.md) for the example props + Twig.
