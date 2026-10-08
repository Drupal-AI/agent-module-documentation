<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views highlight past events lets you visually flag events whose date has already passed in a View, with the past/future check done in the browser so no time-based view caching is needed.
---
The module has no routes or config entities of its own. It alters the Views UI field config form (`hook_form_views_ui_config_item_form_alter`) for any date-type field (detected by the presence of a `timezone_override` setting), adding a "Highlight past events" section: highlight the field only or the whole row, an optional custom CSS class, a highlight colour, and a recalculation interval. These choices are stored as Views third-party settings on the view via custom validate/submit handlers.

At render time `hook_views_pre_render()` reads those third-party settings, converts each row's date field to a Unix timestamp, and passes the timestamps, a CSS selector for the date field, the colour, custom class and interval to JS via `drupalSettings`, then attaches the module's library. The bundled JavaScript compares each timestamp to the current time client-side and applies the highlight colour / custom class to past events (optionally re-checking on an interval). All values are run through `Xss::filter()` before output.
---
- Highlight past events in a View that lists events with a date field.
- Highlight only the date field of past events.
- Highlight the entire row of past events.
- Pick the highlight colour with the colour picker.
- Add a custom CSS class to past rows/fields instead of a colour.
- Set a recalculation interval to re-check dates while the page is open.
- Do the past/future check client-side to avoid time-based view caching.
- Configure highlighting per date field in the Views UI config form.
- Apply to any entity with a date-type field detected via `timezone_override`.
- Reduce server load compared with time-based cache expiry.
- Store settings as Views third-party settings (no separate config entity).
- Combine with Views Auto-Refresh to also refresh the view content.
- Validate the custom CSS class against invalid characters.
- Target the correct field via the generated `.views-field-*` selector.
- Pass event timestamps to JS through drupalSettings.
- Disable highlighting by unchecking "Highlight past dates".
- Flag expired offers, deadlines, or sessions in a listing.
- Style multiple views independently by field/display id.