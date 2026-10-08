<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Font Awesome Formatter for Int List renders a core list_integer field as a fixed row of icons — the stored value as "on" icons and the remainder as "off" icons — so a stored 4 out of 5 shows as four filled stars and one empty one.

---

Ratings, difficulty levels, priority indicators and capacity meters are all stored as small integers and all want to be shown as a row of symbols. This module makes that a Manage-display choice: pick the "FA Int Formatter" formatter on a list(integer) field and paste an icon HTML snippet (default `<i class="fas fa-star"></i>`). For each field value it emits a `<span class="fa-formatter">` wrapper containing that icon markup repeated once per allowed value — `value` copies carry the `star-on` class and the remaining `max - value` copies carry `star-off`, so the total row length always equals the number of options and the "score" reads as filled versus empty glyphs. The whole module is one plugin: `Plugin/Field/FieldFormatter/FAFormatterInt`.

Two practical requirements. First, the icon library is not shipped — the module renders your `<i>` markup and its own small CSS (yellow `star-on`, dark `star-off`), so Font Awesome (or any equivalent icon set, or your own IcoMoon build) must be loaded by the theme or another module for the glyphs to appear; the missing-icon symptom is blank space where the rating should be. Second, the icons are decorative repetitions of a number — the module hides the numeric value off-screen with CSS, so confirm the underlying value is still exposed to assistive technology rather than leaving a screen reader with a wall of unlabelled glyphs.

---

- Show a stored rating as a row of filled-and-empty stars.
- Render a difficulty level as repeated icons out of a fixed maximum.
- Display a priority as flags or bars against a scale.
- Show a capacity or satisfaction score as icons.
- Turn a list(integer) select field into a visual scale.
- Pick the icon HTML per field display (any `<i>` snippet).
- Use a non-Font-Awesome icon set (IcoMoon, a custom font) with the same markup.
- Replace a per-view Twig loop in a template override.
- Keep rating display consistent across view modes and bundles.
- Show a score in a teaser as icons.
- Render a review rating in a Views listing.
- Reuse Font Awesome icons already loaded by the theme.
- Give editors a numeric select and visitors a graphic row.
- Show both filled and empty positions so the maximum is visible.
- Style filled vs empty glyphs differently via the module's `star-on`/`star-off` CSS.
- Display a book or product rating without any interactive rating widget.
- Configure the icon once and reuse it across every entity of the bundle.
- Fall back to a "no rating yet" message when the field is empty.
- Keep the source data a plain integer for sorting and filtering.
- Render ratings in search results consistently with the entity page.
