Link Field tweaks is a small collection of usability tweaks for core's Link field: reorder the title/URL inputs, add custom help text to each part, make the URL required when a title is entered, relabel "Add another item", extend entity-autocomplete labels, and two "fixed link text" field formatters.

---

The module alters core's `link_default` widget and the `link` field via hooks — it adds no field type of its own. A site-wide settings form (`link_field_tweak.settings`, at *Configuration → Content authoring → Link field settings*, `/admin/config/content/link-field-tweak`) exposes three global toggles: `widget_field_order` (show the Title input before the URL input, D7-style), `add_another_link` (relabel the widget's "Add another item" button to "Add another link"), and `uri_part_required` (mark the URL required in the front-end when the Title is filled). The same behaviors can also be set **per widget** as third-party settings on a field's *Manage form display* widget (`link_default_field_order`, `uri_part_required`), plus per-widget-only options: `uri_part_custom_help` / `uri_part_custom_help_text` (override the URL help text), `title_part_custom_help` / `title_part_custom_help_text` (add title help text), and `autocomplete_route_name_change` (extend autocomplete match labels with entity id + bundle, via a custom EntityReferenceSelection handler `nodeextend` and an autocomplete controller). For display it adds two field formatters — `link_text` ("Link text": always render fixed text, XSS-filtered, overriding the field's link text) and `link_text_empty` ("Link text replacing empty text": use fixed text only when the link title is empty). Widget third-party settings live in the `entity_form_display` config; formatter settings in the `entity_view_display` config.

---

- Show the link Title field above the URL field (as Drupal 7's Link module did), site-wide.
- Switch title-before-URL for just one specific link field widget.
- Replace the default "Start typing…" URL help text with a custom instruction on a link field.
- Add help text under the link Title input (which core leaves without any help).
- Make the URL required in the browser as soon as an editor types a link title.
- Enforce URL-required-when-titled for every link widget site-wide with one checkbox.
- Rename the multi-value "Add another item" button to "Add another link".
- Render a link with fixed anchor text (e.g. always "Read more") regardless of stored title.
- Use fixed text only when a link has no title, keeping real titles where present (`link_text_empty`).
- Present cleaner call-to-action links whose visible text is controlled by the formatter.
- Extend link-field entity autocomplete matches to show the node id and bundle label.
- Disambiguate autocomplete results that share the same title using the appended id/bundle.
- Configure link-widget tweaks per form mode (e.g. only on the default form).
- Keep the URL optional but strongly guided via custom help text.
- Roll out consistent link-widget UX across many content types via the site-wide settings.
- Override link help text per field for editor guidance without patching core.
- Provide a fixed "Download" label on a link field used for file URLs.
- Standardize CTA button text across a site by setting the formatter's link_text.
- Avoid editors leaving a link title blank by guiding them with title help text.
- Combine site-wide defaults with per-field overrides (per-field wins where the global is off).
- Export the tweaks as config (`link_field_tweak.settings` + widget third-party settings) for deployment.
- Improve accessibility by adding descriptive help to the URL and title inputs.
- Use the `nodeextend` selection handler to enrich autocomplete for link fields.
- Keep link text safe: the `link_text` formatter runs the fixed text through `Xss::filter()`.
