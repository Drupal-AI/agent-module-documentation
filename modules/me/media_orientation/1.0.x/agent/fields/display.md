<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter & widget

The stored orientation is a raw integer (1/2/3). These two plugins render it as the word
**Landscape / Portrait / Square** instead. Both target `list_integer` fields and use
`Orientation::getLabel()`.

| Type | Plugin id | Class | Label | Purpose |
|---|---|---|---|---|
| Field formatter | `media_orientation_label` | `OrientationLabelFormatter` | "Orientation label" | Display (view mode): renders each value's label via `#plain_text`; falls back to the raw value if unknown. |
| Field widget | `media_orientation_readonly` | `OrientationReadonlyWidget` | "Orientation label (read only)" | Form display: shows the label as a read-only `#type => item`, keeps the value in a `#type => hidden` element. Shows "Not set" when empty. Its `isApplicable()` gates it to `list_integer` fields. |

## How to apply
- Display: on the media type's **Manage display** (`/admin/structure/media/manage/<bundle>/display`), set the orientation field's format to **Orientation label**.
- Form: on **Manage form display**, set the orientation field's widget to **Orientation label (read only)** so editors see the word but cannot change the auto-computed value.

## Notes
- The formatter emits `#plain_text`, so output is auto-escaped; the widget's markup comes only from the module's fixed label strings passed through `t()` — no user-controlled text is rendered.
- Labels are the fixed strings from `Orientation::getLabel()` (see [../api/orientation.md](../api/orientation.md)); values outside 1–3 print as the raw number.
