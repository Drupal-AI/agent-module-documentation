<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime More Datelist Widget

Extends core's Datelist datetime widget so you can store a much wider year range (1-9999) and capture seconds, by rendering the parts as numeric inputs with sensible min/max bounds.

- Registers a `datelist_more` form element extending core `Datelist`.
- Lets year/month/day/hour/minute/second parts render as `number` fields.
- Useful for historical dates or precise timestamps core's widget cannot express.

---

## Installation & configuration

- Depends on core **field** and **datetime**; enable it.
- On a datetime field's **form display**, choose the "Datelist more" widget.
- Configure min year and max year for the field.
- Choose number vs select rendering for date/time parts.
- No permissions or routes are provided.
- Works with existing datetime field storage.

---

## Usage & behaviour

- The element class is `src/Element/DatelistMore.php` (`@FormElement("datelist_more")`).
- `processDatelist()` calls the parent then converts requested `#date_text_parts` to `number` inputs.
- Year gets `#min`/`#max` from `#date_year_range`; month 1-12, day 1-31, hour 0-23, minute/second 0-59.
- `hook_element_info` registers the element; `hook_help` documents usage.
- Purely a form-widget/element concern — no data access surface.
- Bounds are enforced client-side via number input attributes and server-side by the datetime element.
- Supports seconds, which core's Datelist omits by default.
- Ideal for year values outside core's typical range.
- No external calls, no DB queries, no custom permissions.
- Config for the widget lives in the field's form-display config.
- Combine with core datetime formatters for display.
- Multilingual-safe; it only affects input rendering.
- The `config/` directory holds any provided schema/defaults.
- Uninstall reverts fields to whatever widget you reselect.
- Read: `src/Element/DatelistMore.php`, `datetime_more.module`.
