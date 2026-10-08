Starrating provides a simple `starrating` field type plus display formatters that show an integer score as a row of icons (stars, hearts, etc.) — an editor-set rating, not an end-user voting widget.

---

The module adds one field type (`starrating`, a tiny integer column) with a select-list widget
(`0…max_value`, 0 = "Not selected") and three formatters: `starrating` (renders the score as
icons via the `starrating_formatter` theme hook + a per-icon CSS library), `starrating_value`
(the raw number), and `starrating_value_rating` (the number as `rate/max`, e.g. `8/10`). The
per-field setting `max_value` (1–10, default 10) caps the rating; the icon formatter's settings
are `icon_type` (17 choices: star, starline, heart, dollar, smiley, food, coffee, movie, music,
human, thumbsup, car, airplane, fire, drupalicon, custom…), `icon_color` (1–8), and `fill_blank`
(also draw empty icons up to max). It deliberately does **not** provide AJAX voting, a voting
API, or any admin config page — ratings are entered by the content author on the entity form,
so it suits things like a reviewer scoring food/price/service on a restaurant node. It requires
only core `field`, defines no routes, permissions, services, or Drush commands, and styles each
icon set through a CSS library named after the icon type (`starrating/<icon_type>`).

---

- Add an author-entered "food", "price" and "service" score to a restaurant review node.
- Display a movie review's rating as filled stars out of a configurable maximum.
- Show a rating as plain text `8/10` using the `starrating_value_rating` formatter.
- Render the raw numeric score with the `starrating_value` formatter for use in a template.
- Use heart icons instead of stars for a "loved it" rating field.
- Cap a rating field at 5 (or any value 1–10) via the field's `max_value` setting.
- Give a product-review content type an editor-set quality score.
- Use thumbs-up icons for a simple approval indicator.
- Show empty/blank icons up to the maximum with the `fill_blank` formatter option.
- Pick one of eight color variants for the rating icons (`icon_color`).
- Use coffee or food icons for a cafe/menu rating.
- Add multiple independent rating fields (different icons) to one node.
- Provide a fire-icon "spiciness" rating on a recipe.
- Display a dollar-icon "price level" indicator on a listing.
- Style a bespoke icon set by choosing the `custom` icon type and overriding its CSS.
- Present a staff-assigned score on an article without enabling any voting module.
- Show a rating in a View by adding the starrating field with its formatter.
- Use the select-list widget so editors pick a whole-number score on the edit form.
- Keep ratings lightweight (a single tiny-int column) with no dependencies beyond core field.
- Export the field/formatter configuration for deployment (schema-backed settings).
- Combine the numeric and icon formatters across different view modes of the same field.
- Provide an airplane-icon rating for a travel/flight review.
