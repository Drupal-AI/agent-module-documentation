Views Autocomplete API turns any View into an autocomplete (typeahead) endpoint that returns JSON suggestions built from the View's fields.

---

Autocomplete widgets are normally built one at a time: a controller, a hand-written query, a JSON response, an access check. Views Autocomplete API replaces that pattern with configuration. You build a View whose exposed filter matches the typed text, point a textfield's `#autocomplete_route_name` at the module's route, and the module runs the View for each keystroke and returns its rendered fields as `{value, label}` suggestion objects. Filters, sorts, contextual arguments, the result limit, the display's header/footer/empty areas and the View's own access all come from the View, so the endpoint behaves like the rest of the site rather than like bespoke code. The last field of the View becomes the visible label; the field before it becomes the plain-text value written into the input on selection. A single request can query several Views at once (comma-separated names, per-View display ids and arguments), and an optional highlight setting wraps the matched substring in a span. A ships-with demo submodule (`views_autocomplete_api_demo`) wires two example Views to the core search block.

---

- Add autocomplete to any Form API textfield by setting `#autocomplete_route_name` to `views_autocomplete_api`.
- Drive typeahead suggestions from a View instead of writing a custom controller.
- Build a user-search box that completes on name or email via an exposed OR filter.
- Autocomplete node titles filtered by content type using a non-exposed filter.
- Query several Views in one autocomplete request (comma-separated `view_name`).
- Use a specific View display per source with the `display_id` route parameter.
- Pass contextual/argument values to the queried Views via `views_arguments`.
- Show a rendered field (image + link + text) as the suggestion label by rewriting the last field.
- Return a plain-text value for injection into the field using the second-to-last field.
- Add a "see all results" link in the View header using the `[autocomplete]` token.
- Show a custom "no results" message via the View's empty-area text.
- Highlight the matched search term in results by enabling the highlight setting.
- Reuse an existing Search API-backed View as an autocomplete source.
- Limit suggestion count with the View's pager/items-per-page setting.
- Restrict which rows can appear by adding non-exposed filters to the View.
- Apply the View's access plugin so suggestions honor site permissions.
- Replace the core search block's field with an autocomplete via `hook_form_alter`.
- Sort suggestions with the View's configured sort handlers.
- Prototype an autocomplete quickly by enabling the demo submodule and its example Views.
- Localize suggestion labels through the View's normal field rendering.
- Combine published and other Views into one merged suggestion list.
- Audit or document a site's autocomplete endpoints that are defined as Views.
