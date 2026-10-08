Date Popup replaces the plain text date inputs in Views exposed filters with native HTML5 date (and datetime) pickers, so site visitors get a browser calendar widget when filtering by date.

---

The module is tiny and has no configuration. On install it alters the Views filter plugin registry (`hook_views_plugins_filter_alter`) to swap the class of the core `date` and `datetime` filters — and the Search API `search_api_date` filter when present — for its own subclasses. Those subclasses extend the standard filter and, in `buildExposedForm()`, apply an HTML5 date/datetime input to the exposed form element via a shared trait. The result is that any exposed date filter on any View automatically renders as a `#type => date` (or datetime-local) control, giving users a native calendar picker instead of having to type a date string in the expected format. It supports both core datetime fields and Search API date filters, works across Drupal 8 through 12, and requires no per-View setup beyond exposing the filter.

---

- Show a native calendar picker on a "created date" exposed filter.
- Let users pick an event start date from a browser date widget.
- Replace free-text date entry that requires an exact format.
- Add HTML5 date inputs to any exposed Views date filter automatically.
- Provide a datetime-local picker for datetime field filters.
- Give Search API date filters an HTML5 picker (`search_api_date`).
- Improve UX of a date-range "between" exposed filter.
- Reduce invalid-date input errors on public listing pages.
- Filter a blog archive by publication date with a calendar.
- Filter a content list by an updated/changed date.
- Offer accessible, mobile-friendly date entry on exposed forms.
- Filter commerce orders by order date via a picker.
- Filter a calendar/event View by date without custom code.
- Keep a consistent date-entry UX across all Views on a site.
- Avoid needing a custom form alter for exposed date filters.
- Support "greater than / less than" date operators with a picker.
- Enhance faceted date filtering on a Search API index.
- Localize date entry to the user's browser date format.
- Filter a report by a start and end date range.
- Modernize legacy date filters when upgrading Drupal.
