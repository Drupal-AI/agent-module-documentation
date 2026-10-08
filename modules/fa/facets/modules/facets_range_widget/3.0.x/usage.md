Facets Range Widget adds slider and range-slider facet widgets (with matching processors) so numeric fields like price or age can be filtered with a draggable min/max slider instead of a list of values.

---

This facets submodule provides two widget plugins — `SliderWidget` (single-handle) and `RangeSliderWidget` (two-handle min/max) — plus companion processor plugins (`SliderProcessor`, `RangeSliderProcessor`) that compute the range bounds from indexed values and prepare the facet results for the slider UI. The widgets render a jQuery UI slider, which is why the module depends on the `jquery_ui_slider` and `jquery_ui_touch_punch` contrib modules (touch punch makes the slider usable on touch devices). It ships its own CSS/JS and a config schema for the widget settings. Combined with a numeric or range query type, it turns a facet into a continuous range control rather than discrete checkboxes. Use it for prices, distances, ratings, years, or any numeric facet where a slider reads better than a long value list.

---

- Add a price range slider to a product search page.
- Filter listings by a minimum and maximum value with two handles.
- Provide a single-handle slider for "up to X" filtering.
- Facet on year of publication with a draggable range.
- Filter properties by square footage or number of rooms.
- Add a distance/radius slider to a location search.
- Let users pick a rating range (e.g. 3–5 stars).
- Filter events by date range using a slider.
- Provide touch-friendly range selection on mobile (via touch punch).
- Replace a long numeric checkbox facet with a compact slider.
- Filter salary bands on a job board.
- Set an age-range filter on a member directory.
- Bound results by file size or duration on a media library.
- Combine a range slider with other facet widgets on one page.
- Style the slider to match the site theme via the module's CSS.
- Auto-compute slider min/max from the indexed data.
- Filter by percentage or score ranges.
- Offer a weight/dimension range facet for a catalog.
- Provide a calorie or nutrition range filter on recipe search.
- Use the range slider inside a Search API faceted view.
