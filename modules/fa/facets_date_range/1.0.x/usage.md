Facets Date Range adds a Date Range Picker widget and a matching processor to the Facets module, letting site visitors filter search results by a minimum and/or maximum date through two date inputs.

---

The module extends [Facets](https://www.drupal.org/project/facets) with two plugins and no admin page of its own (configure is null). The **`date_range` widget** (`src/Plugin/facets/widget/DateRangeWidget.php`, extends `WidgetPluginBase`) renders two HTML5 `#type => 'date'` inputs ("min" and "max", with configurable labels) and attaches the `facets_date_range/date-range` JS library, which reads `drupalSettings.facets.daterange[<facet id>].url` and rebuilds the facet URL as the user changes the dates. Its query type is `range`, and it requires the module's processor to be enabled (`isPropertyRequired('date_range')`). The **`date_range` processor** (`src/Plugin/facets/processor/DateRangeProcessor.php`) runs at the `pre_query` and `build` stages: at build time it injects a URL template `(min:__date_range_min__,max:__date_range_max__)` that the JS fills in; at pre-query time it parses the active `(min:…,max:…)` item into a numeric range for the backend, with an optional `max_inclusive` setting that extends the max to end-of-day. You configure it per facet on the normal Facets edit form: pick the "Date Range Picker" widget, set the min/max labels, and enable the "Date Range Picker" processor (optionally ticking "Include through end of max date"). Values are stored as facet config (schema `facet.widget.config.date_range` and `plugin.plugin_configuration.facets_processor.date_range`).

---

- Add a from/to date filter to a Search API facet.
- Let users narrow search results to items after a minimum date.
- Let users narrow search results to items before a maximum date.
- Filter results to a specific date window (both min and max).
- Replace a long list of individual date facet links with two compact date inputs.
- Customize the "from" input label (default "Date from").
- Customize the "to" input label (default "Date to").
- Include results through the end of the max day via the `max_inclusive` processor option.
- Exclude same-day-after-midnight results by leaving `max_inclusive` off.
- Provide a date-range facet on a content search page (articles by publish date).
- Filter an events listing by event date range.
- Filter commerce/product results by a date field.
- Build a "last updated between" filter over a changed/updated date field.
- Use with Facets 1.x, 2.x, or 3.x (composer allows `^1.6 || ^2.0 || ^3.0`).
- Drive the facet entirely client-side (JS rewrites the facet URL as dates change).
- Keep the min-only case open-ended (max defaults far in the future).
- Keep the max-only case open-ended (min defaults to the Unix epoch).
- Combine the date-range facet with other facets on the same search.
- Expose the date-range facet in a block or inline facet region.
- Avoid writing a custom range widget by reusing this ready-made one.
