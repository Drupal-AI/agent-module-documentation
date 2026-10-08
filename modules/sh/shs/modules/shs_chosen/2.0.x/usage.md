Simple hierarchical select: Chosen (shs_chosen) adds the Chosen jQuery plugin to the SHS cascading dropdowns, turning each level select into a searchable, styled Chosen box.

---

shs_chosen is a submodule of Simple Hierarchical Select that layers the [Chosen](https://www.drupal.org/project/chosen) library over the SHS cascading widget. It provides a second field widget, `options_shs_chosen` (`OptionsShsChosenWidget`), which extends the base `options_shs` widget and adds the `shs_chosen/shs_chosen.form` library — a pair of Backbone view overrides (`ChosenAppView`, `ChosenWidgetView`) that re-render each level `<select>` as a Chosen control with a type-ahead search box. It reuses all of SHS's per-level AJAX loading and settings, and adds two config keys: `chosen_override` (use custom Chosen settings for this field instead of the global ones) and a `chosen_settings` group (disable search, search-in-middle-of-words, and the placeholder / "no results" texts). When `chosen_override` is off it inherits the site-wide `chosen.settings` configuration. The submodule also mirrors SHS's Views integration, swapping the `taxonomy_index_tid` / `taxonomy_index_tid_depth` filter classes to the Chosen-aware variants so exposed hierarchical filters get Chosen too. It requires both the `shs` and `chosen` modules to be enabled.

---

- Add a searchable type-ahead box to each level of an SHS cascading taxonomy widget.
- Style the hierarchical select levels with the Chosen jQuery plugin.
- Use the `options_shs_chosen` widget on a single-vocabulary term-reference field.
- Let editors filter long child-term lists by typing instead of scrolling.
- Inherit the site's global Chosen configuration for consistent behavior.
- Override Chosen settings per field with the `chosen_override` toggle.
- Disable the Chosen search box for short lists via `disable_search`.
- Match search terms in the middle of words with `search_contains`.
- Set custom placeholder text for single and multi-value selects.
- Customize the "No results match" message shown when a search finds nothing.
- Give a multi-value hierarchical term field Chosen styling on every level.
- Apply Chosen to the SHS exposed filter in Views ("Has taxonomy terms").
- Apply Chosen to the depth-aware Views term filter as well.
- Keep SHS's per-level AJAX child loading while gaining Chosen search.
- Provide a nicer picker for deep vocabularies (regions, categories, product trees).
- Link Chosen appearance to the global chosen admin settings page.
- Swap only the Backbone app/widget view classes so the rest of SHS is unchanged.
- Roll out searchable hierarchical selects without writing custom JavaScript.
