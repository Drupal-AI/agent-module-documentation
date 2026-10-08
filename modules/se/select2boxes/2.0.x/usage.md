Turns Drupal select/multiselect and entity-reference form elements into searchable Select2 autocomplete widgets, either per field via dedicated field widgets or globally for every `<select>` on the site.

---

Select2 Boxes wires the third-party [Select2](https://select2.org/) jQuery library (loaded from a configurable CDN URL/version, default cloudflare 4.0.5) into Drupal forms. It ships three field widgets — `select2boxes_autocomplete_single` and `select2boxes_autocomplete_multi` for entity-reference fields, and `select2boxes_autocomplete_list` for `list_string`/`list_integer`/`list_float`/language fields — each extending core's options/select widget and adding `select2-widget` data attributes the module's JS enhances. A global config page (`/admin/config/user-interface/select2boxes`, permission `administer site configuration`) can instead enable Select2 for *all* dropdowns via `template_preprocess_select`, optionally excluding admin routes, and can hide the search box until a list reaches a minimum length. Widget third-party settings add extras per field: preloading a capped number of entries for multi-value autocompletes, and flag icons for language/country fields (requires the `flags` module). It also integrates with the `address` module's country/zone selects. Auto-create ("add new term") entity-reference fields are supported via a value-callback that creates the referenced entity on submit. A `select2_bef` submodule brings the same widget to Better Exposed Filters exposed filters.

---

- Make a long taxonomy or entity-reference dropdown searchable with type-ahead.
- Replace a multi-value entity-reference `<select multiple>` with tag-style Select2 chips.
- Add autocomplete to a `list_string`/`list_integer` options field.
- Enable Select2 on every dropdown across the whole site with one global toggle.
- Keep Select2 off admin pages while enabling it globally on the front end.
- Hide the Select2 search box until an option list is longer than a configured minimum length.
- Choose which CDN and Select2 version (4.0.1–4.0.5) to load from the settings form.
- Preload a fixed number of options into a multi-value autocomplete for faster first interaction.
- Preload *all* options into a multi-value autocomplete when the set is small.
- Show country/language flag icons beside options on country or language fields (with the flags module).
- Add Select2 to Address module country/zone selects via a per-widget toggle.
- Let editors auto-create new taxonomy terms directly from a Select2 entity-reference field.
- Provide a consistent select UX across all content forms without custom JS.
- Turn a Views exposed filter into a Select2 dropdown using the select2_bef submodule.
- Give exposed filters an autocomplete search box for large option lists (select2_bef).
- Allow multi-select exposed filtering with Select2 chips in a Views exposed form (select2_bef).
- Reduce mis-selection on big country/language pickers by adding search + flags.
- Standardize dropdown styling site-wide with the bundled Select2 theme CSS.
- Preload Select2 when BigPipe is enabled so the widget initializes reliably.
- Flatten multi-bundle grouped option lists to avoid key collisions in Select2.
- Self-host or pin a specific Select2 version by editing the CDN URL and version.
- Improve accessibility/usability of overloaded option lists with searchable, keyboard-friendly selects.
