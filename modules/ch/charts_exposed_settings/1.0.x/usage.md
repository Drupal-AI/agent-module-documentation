Charts Exposed Settings adds Views field and filter handlers that let a Views chart's title, subtitle, and X/Y axis labels be set from exposed form input (or matching URL query parameters) at view time.

---

The module is a small add-on for the Charts module. It registers four global Views handlers — `field_exposed_title`, `field_exposed_subtitle`, `field_exposed_xaxis_title`, and `field_exposed_yaxis_title` — each available as both a field and a filter, so a site builder can drop them onto any View and expose them. At render time an implementation of `hook_views_pre_view()` inspects the request for the query parameters `chart_title`, `chart_subtitle`, `x_axis_title`, and `y_axis_title`; for any that are present, it overrides the corresponding key in the Charts style plugin's `chart_settings` (paths `display/title`, `display/subtitle`, `xaxis/title`, `yaxis/title`) after passing the value through `Xss::filter()`, and adds the `url` cache context so the result varies per query string. It only acts when the view's style plugin is `ChartsPluginStyleChart`. There is no configuration UI, no permissions, no routes, no stored config beyond the per-view handler options, and no database query work (the handlers' `query()` methods are intentionally empty).

---

- Let end users retitle a Views chart on the fly by typing into an exposed form field.
- Expose a chart subtitle input so visitors can annotate a rendered chart.
- Let visitors relabel the X-axis of a chart without a new View or config change.
- Let visitors relabel the Y-axis of a chart from the exposed form.
- Drive chart titles from URL query parameters (e.g. `?chart_title=Sales`) for shareable/deep-linkable chart pages.
- Pre-populate a dashboard chart's labels via links that carry `chart_title`/`x_axis_title`/`y_axis_title` query strings.
- Build a single reusable chart View whose captions are customized per embedding page through query params.
- Add the exposed inputs as filters when you want them to appear in the standard exposed filters block.
- Add the exposed inputs as fields when you prefer field-style placement/handling in the View.
- Combine with the exposed filters block placed in a region to give a chart a "customize labels" control panel.
- Allow report builders to label the same data chart differently for different audiences via one URL each.
- Provide localizable-by-link chart captions where the query param supplies a translated string.
- Let editors preview alternative chart titles quickly without editing the View.
- Support A/B-style caption experiments by varying the title query parameter.
- Give an embedded chart (iframe/AJAX) its captions from the parent page's parameters.
- Use exposed axis-title inputs to clarify units (e.g. "Revenue (USD)") on demand.
- Keep chart markup identical across pages while varying only the human-readable labels.
- Attach the handlers to any chart View regardless of its base table (they are registered under the Global group).
- Override only the labels you need — unset parameters leave the View's configured defaults intact.
- Serve per-request chart captions safely, since supplied values are run through Drupal's XSS filter before display.
