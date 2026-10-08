<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Percentage Field adds a percentage field type with its own widget and formatter.

---

Simple Percentage Field defines a `simple_percentage` field type (`SimplePercentageItem`), a default widget (`SimplePercentageDefaultWidget`) and a default formatter (`SimplePercentageDefaultFormatter`), plus a `simple_percentage` theme for rendering. It also registers the field type with core's string formatter. Formatter options include an absolute value, numeric position/prefix/suffix, and showing configured min/max values. Depends on core `field`. A pure field module: no routes, no permissions, no external calls.

---

- Store a percentage value on an entity.
- Provide a dedicated percentage field type.
- Edit percentages with a custom widget.
- Display percentages with a custom formatter.
- Show a numeric prefix or suffix.
- Control the numeric position in output.
- Optionally show min and max values.
- Render an absolute value.
- Reuse a Twig theme for output.
- Register with core's string formatter.
- Add the field via Manage fields.
- Configure display via Manage display.
- Work on Drupal 8, 9 and 10.
- Depend only on core field.
- Avoid custom code for percentage fields.
- Keep a small, focused field type.
