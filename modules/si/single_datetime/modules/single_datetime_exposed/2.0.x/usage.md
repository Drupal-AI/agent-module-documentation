<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Time Exposed Views Filters is a submodule of single_datetime that automatically attaches the xdan jQuery datetimepicker to every **date-type exposed filter** on a View — no configuration required.

---

The submodule is a single form-alter with no config, settings form, plugin, or service. It implements `hook_form_BASE_FORM_ID_alter()` for `views_exposed_form` (`single_datetime_exposed_form_views_exposed_form_alter()`). For each exposed filter on the View it checks two conditions: the filter's `plugin_id` is `date` **or** `search_api_date`, and its `value.type` is `date` (i.e. an absolute-date filter, not a relative/offset one). Matching filters get the datetimepicker `data-*` attributes from `\Drupal\single_datetime\AttributeHelper::defaultWidget()`. For `between` / `not between` operators it applies the attributes to both the `min` and `max` sub-inputs and relabels them "( From )" / "( To )" (and, if only a min value is submitted, auto-fills the max with min + 1 day so the range filter still works); for all other operators it applies the attributes to the single filter input. If any matching filter was found it attaches the `single_datetime/datetimepicker` library so the picker initialises. It intentionally skips Views live-preview (`$view->preview === NULL`). Its info.yml declares only a dependency on `single_datetime`, but it also requires **Views** (core) for the exposed form to exist, and the parent module's xdan JS library at `/libraries/jquery-datetimepicker`. The README notes that for customised behaviour you should create your own implementation based on this submodule.

---

- Give every exposed date filter across your site's Views a calendar+time picker automatically, with zero per-view configuration.
- Add a datetimepicker to an exposed "Authored on" (created) date filter on a content listing View.
- Turn a Views `between` date-range exposed filter into two datetimepicker inputs labelled "From" and "To".
- Attach the picker to a Search API `search_api_date` exposed filter on a faceted search View.
- Provide a friendly date picker on an exposed "Updated" (changed) filter for an admin content View.
- Ensure a range exposed filter still returns results when the editor only fills the "From" date (auto max = From + 1 day).
- Standardise the date-entry UX of all exposed filters site-wide by simply enabling the submodule.
- Replace the default free-text date input on exposed Views filters with the xdan picker on the front end.
- Use the picker on an events calendar View's exposed start-date filter so visitors pick a date visually.
- Give a "published between" report View a from/to datetimepicker without writing any code.
- Add pickers to exposed date filters on a block-displayed View (the alter runs on the block's exposed form too).
- Avoid a custom themed date field for exposed filters by relying on this automatic attachment.
- Keep exposed date filters consistent with entity-form date pickers (both use the same xdan library).
- Offer date selection on an exposed filter for a taxonomy-term listing filtered by a date field.
- Provide a datetimepicker on an exposed filter that uses the "is between" operator on a datetime field surfaced as a Views `date` filter.
- Serve as a starting template for a bespoke exposed-filter datetimepicker (copy and customise the form alter).
- Roll the picker out to editors' saved-search Views without touching each View's configuration.
- Enhance an exposed date filter on a REST/AJAX View's exposed form used elsewhere on the page.
