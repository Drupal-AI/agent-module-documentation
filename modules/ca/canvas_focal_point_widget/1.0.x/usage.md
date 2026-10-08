<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Canvas Focal Point Widget adds a visual, per-instance focal-point picker and scale slider to image props of Canvas (Experience Builder) components.

---

Canvas Focal Point Widget is a client-side helper for the **Canvas** (Experience Builder) page builder. When an editor is filling in a component instance form that has number props named `{prefix}_focal_x` and `{prefix}_focal_y` (and optionally `{prefix}_scale`), the module's JavaScript behavior draws a live thumbnail of the currently selected media with a draggable, keyboard-accessible focal-point dot on top of it, plus an optional 100–200 % scale slider. Moving the dot or slider writes plain percentage values back into the underlying numeric inputs, which Canvas stores as ordinary component prop values — so the crop is chosen **per placement**, not globally on the media entity. The component author is responsible for defining the props in the component's YAML and consuming them in Twig (typically via CSS `object-position` and `transform: scale()`). The module ships only JS, CSS and one PHP hook that makes the widget library load with the Canvas UI; it has no routes, no permissions, no settings form, and no server-side processing of the values.

---

- Let editors set an image's focal point per Canvas component placement instead of globally on the media entity.
- Reuse one media item across a hero and a card with a different focal point in each.
- Drag a dot over a live thumbnail to pick the focal point visually.
- Nudge the focal point precisely with arrow keys (Shift for a 10× step) for keyboard/accessible editing.
- Add an optional 100–200 % zoom by including a `{prefix}_scale` prop on the component.
- Auto-attach the picker to any component form whose props follow the `{prefix}_focal_x` / `{prefix}_focal_y` naming convention — no per-component setup in this module.
- Support multiple independent focal-point props on the same component (e.g. `bg_focal_x` and `logo_focal_x`) by giving each its own prefix.
- Keep the picker working after Canvas re-renders the form over AJAX (media selection, prop changes).
- Feed `object-position: {x}% {y}%` in a component's Twig to render the chosen crop.
- Feed `transform: scale()` from the scale prop to render an in-container zoom.
- Preview the exact focal point live as a thumbnail while editing.
- Store focal-point and scale values as normal component prop numbers (0–100 / 100–200).
- Build responsive hero banners where the subject stays in frame across breakpoints.
- Build media cards, tiles, and grids that keep the important part of each image visible.
- Give content teams a Photoshop-free way to reframe images inside the page builder.
- Reuse `Drupal.canvasFocalPointWidget.setNativeValue` from another module to write React-controlled inputs.
- Ship the picker with no configuration — install, enable, and it works on matching props.
- Avoid regenerating media derivatives just to change how a single placement is cropped.
