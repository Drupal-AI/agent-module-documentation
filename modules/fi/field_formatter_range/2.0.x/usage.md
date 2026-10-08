<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Formatter Range adds **order**, **display items (limit)**, and **skip items (offset)** controls to any field formatter on a multi-value field, so you can show a subset of a field's values (e.g. only the first 2, reversed, or a random pick) without a View or custom code.

---

The module is a formatter-level enhancement built entirely from hooks — it defines no field type, widget, or formatter of its own. On a bundle's *Manage display* page it injects a "Field Formatter Range" settings group into the third-party settings of **every** field formatter (`hook_field_formatter_third_party_settings_form`), but only when the field's cardinality is not 1 (single-value fields have no range to speak of). The three settings are `order` (0 = Default, 1 = Reverse, 2 = Random), `limit` ("Display items", 0 = all), and `offset` ("Skip items"). They are saved as a third-party setting on the formatter component in the `entity_view_display` config entity (`content.<field>.third_party_settings.field_formatter_range`), validated by the config schema `field.formatter.third_party.field_formatter_range` (three integers). At render time `hook_preprocess_field` reads those settings and reorders/slices the already-built field items: it reverses or shuffles the children, then `array_slice`s by offset and limit, and re-indexes so deltas start at 0. A settings-summary hook prints a human-readable line (e.g. "Display 2 items in reversed order. Offset by 1."). The effect is purely display-side; stored field values are untouched, and it works in normal view modes and in Layout Builder component formatters.

---

- Show only the first N values of a multi-value field in a given view mode.
- Display the most recent items by reversing a field whose values are in chronological order.
- Show a single random value from a multi-value field each page load.
- Skip the first item (offset) and show the rest — e.g. hide a "featured" first image in a grid.
- Show items 2–4 by combining offset and limit on an image or link field.
- Reverse the display order of a multi-value taxonomy/entity-reference field without re-saving data.
- Limit a long multi-value text field to the first few entries in a teaser view mode.
- Configure different ranges per view mode (full shows all, teaser shows 1).
- Apply a range to a formatter inside a Layout Builder block/component.
- Present a "latest 3" list from a repeating field without building a View.
- Randomize testimonial or quote order on each render.
- Trim a gallery to a fixed number of images while keeping all values stored.
- Show only the newest value of a multi-value date field by reversing + limit 1.
- Keep the data model multi-value but curate what visitors see per display.
- Export the range as config (`third_party_settings.field_formatter_range: {order, limit, offset}`) for deployment.
- Turn the behavior off per formatter by setting order 0, limit 0, offset 0.
- Reorder reference field renderings (reverse) for RTL or reverse-chronological UX.
- Cap the number of rendered paragraphs/media items in a specific display.
- Offset past a header/pinned item and show the remainder.
- Provide "show first item only" behavior for accordions/carousels driven by a multi-value field.
- Avoid custom preprocess code just to slice a field's output.
- Combine reverse order with a limit to show the "last N" items.
- Apply per-bundle display curation on entity reference, link, text, image, or number fields alike (formatter-agnostic).
