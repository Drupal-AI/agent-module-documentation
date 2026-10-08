<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Layout Classes provides a field widget for point-and-click selection of Bootstrap grid/utility classes and a formatter that renders the stored class string onto the entity's wrapper instead of printing it.

---

The module targets a plain-text (`string`/`text`) field of cardinality 1. Its widget (`bootstrap_layout_classes_widget`) presents editors with breakpoint-aware select boxes and checkboxes — columns, offset, order, margin, padding, gutter, container, align-items, align-self, justify-content and a free-text "custom classes" box — and serializes the choices into a single space-separated Bootstrap class string (e.g. `col-md-6 mt-3 px-2 container`). The companion formatter (`bootstrap_layout_classes_formatter`) suppresses normal field output; a `hook_entity_view_alter()` implementation then splits the stored value and adds each token, sanitized through `Html::getClass()`, to the rendered entity's `#attributes['class']`. This lets editors drive Bootstrap layout from content without hand-editing templates or class strings. It depends only on core Field, has no routes, permissions, services or admin settings — all configuration lives in the field's form-display and view-display settings.

---

- Let editors pick Bootstrap grid column widths per breakpoint (sm/md/lg/xl/xxl) on a field.
- Add responsive margin and padding utility classes (mt/mb/ml/mr, pt/pb/pl/pr, and x/y shorthands) without touching CSS.
- Apply `container` / `container-fluid` wrappers to a content item.
- Set Bootstrap `offset-*` classes to indent columns.
- Reorder flex/grid items with `order-*` classes (including `first`/`last`).
- Control gutter spacing with `gx-*` classes.
- Set `align-items`, `align-self` and `justify-content` alignment classes via selects.
- Allow a free-text "custom classes" box for arbitrary extra utility classes.
- Restrict which class groups editors may set by toggling the widget's per-group checkboxes.
- Configure the widget for a Container, Row, or Column usage context.
- Render the widget wrapper as a collapsible `details` element or a `fieldset`.
- Output the chosen classes onto the entity wrapper instead of printing the raw field value.
- Build Bootstrap-based page layouts from Paragraphs or content-type fields.
- Give a Bootstrap-themed site editor-managed responsive layout without a full page-builder.
- Store layout choices as a single portable class string in one plain-text field.
- Reuse the same layout field across multiple content and paragraph types.
- Provide a compact class-selection UI so editors avoid memorizing Bootstrap class names.
- Combine column, spacing and alignment classes on a single field item.
- Round-trip existing class strings: the widget re-parses stored values back into its controls.
- Compress redundant per-breakpoint selections automatically on save (e.g. dedupe repeated col values, fold equal top/bottom into `my`/`px`).
