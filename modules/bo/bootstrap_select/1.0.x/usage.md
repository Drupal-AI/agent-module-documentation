Bootstrap select picker replaces the plain HTML select on option and entity-reference fields with the third-party bootstrap-select jQuery dropdown (searchable, styled, multi-select-friendly).

---

The module provides one Field API widget, `bootstrap_select_widget` (class `BootstrapSelectWidget`, extending core `OptionsWidgetBase`), that you assign to a field on the *Manage form display* page. It supports the field types `entity_reference`, `list_integer`, `list_float` and `list_string`. At render time a dedicated theme suggestion (`select__bootstrap_select`) swaps in the module's twig template, which attaches the `bootstrap-select` CSS/JS package (from the jsDelivr CDN, or from `/libraries/bootstrap-select` when a local copy exists) plus a tiny init behavior that calls `.selectpicker()` on every `select.bootstrap-select`. Per-field settings map to bootstrap-select `data-*` attributes: Live search, Actions box, Placeholder (rendered as the select `title`), Header, and Selected text format (`value` or `count`, with a `count_selected_text` template). The module has no routes, no permissions, no Drush commands and no site-wide configuration — everything is configured per field on the form display. It requires Bootstrap v4 in the active theme for the widget to look and behave correctly.

---

- Turn a long single-value `list_string` select (e.g. country, state, category) into a searchable dropdown via Live search.
- Give an `entity_reference` field (taxonomy term, node, user) a type-ahead searchable picker instead of a huge scrolling select.
- Enable multi-select on a multi-value option field and let editors pick several values from a styled dropdown.
- Add Select All / Deselect All buttons to a multi-value field with the Actions box option.
- Show "3 items selected" instead of a long comma list on a multi-value field using Selected text format = count.
- Customize the multi-select summary wording with the Count selected text template (`{0}` selected, `{1}` total).
- Add a placeholder / title hint to a select via the Placeholder setting.
- Put a labeled header with a close button at the top of the dropdown via the Header setting.
- Style select widgets consistently with a Bootstrap 4 theme without hand-writing JS.
- Improve UX on `list_integer` / `list_float` rating or quantity fields with a compact picker.
- Configure the widget entirely through the UI at `/admin/structure/types/manage/<bundle>/form-display`.
- Export the chosen widget + settings in `core.entity_form_display.*` config and deploy across environments.
- Serve the bootstrap-select assets locally (privacy / offline / no external CDN) by dropping the library into `web/libraries/bootstrap-select` — the module auto-detects and uses it.
- Keep using the CDN with zero asset management when a local library install is not desired.
- Apply the searchable dropdown to custom entity forms, not just node bundles, since it is a standard Field API widget.
- Provide a "- None -" / "- Select a value -" empty option automatically for optional/required single-value fields.
- Group options into `<optgroup>` sections (the widget declares `supportsGroups()`), preserving grouped option sets in the picker.
- Standardize select styling across many content types by assigning the widget per field on each bundle's form display.
- Read the rendered README/help at `admin/help/bootstrap_select` (rendered with the Markdown module when installed, otherwise as escaped preformatted text).
- Combine Live search with a large entity-reference list to make editorial selection fast without a separate autocomplete module.
