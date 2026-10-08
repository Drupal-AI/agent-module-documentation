Bynder Select2 adds a self-contained [Select2](https://select2.org) integration used by the Bynder upload widget to render nicer multi-select and remote-autocomplete controls for tags and metaproperty options.

---

The submodule ships a Drupal form element (`bynder_select2_simple_element`, extending core `Select`) and a
field widget (`bynder_select2_simple_widget`, extending `OptionsSelectWidget`, for `list_string`/`list_integer`
fields). Both attach the `bynder_select2/bynder_select2.widget` library, which layers the Select2 jQuery
plugin (expected at `/libraries/select2/dist/js/select2.min.js`) over a normal `<select>` and passes
per-instance settings — a unique CSS selector class, placeholder text, `multiple` flag, and an optional
`loadRemoteData` URL for AJAX-populated options — via `drupalSettings.bynder_select2`. The remote-data option
lets a select be populated from an endpoint (e.g. Bynder's tag search) rather than a fixed option list. It is
a UI helper for the parent Bynder module (its only dependency is `bynder`) and self-hosts nothing beyond its
own JS/CSS; the Select2 library itself must be present under `libraries/`. No config, no permissions, no
settings page.

---

- Turn the Bynder upload widget's tag selector into a searchable Select2 multi-select.
- Render metaproperty-option selects as Select2 dropdowns in the upload form.
- Provide a reusable `bynder_select2_simple_element` form element for custom forms needing a Select2 select.
- Attach a Select2 widget to any `list_string`/`list_integer` field via `bynder_select2_simple_widget`.
- Populate a select from a remote endpoint (AJAX) using the element's `#loadRemoteData` URL.
- Give each Select2 instance an isolated selector class to avoid collisions on multi-widget forms.
- Set custom placeholder text on a Select2-enhanced select.
- Enable/disable multiple selection through the standard element `#multiple` property.
- Improve UX for long option lists (search-as-you-type) without extra contrib modules.
- Self-host Select2 from `/libraries/select2` for a CDN-free multi-select control.
- Keep Select2 styling scoped to Bynder widgets via the module's own CSS.
- Reuse the widget for tag entry on Bynder media metadata edit forms.
- Provide type-ahead metaproperty filtering during asset upload.
- Standardize select-box UX across Bynder admin/upload flows.
- Pass Bynder tag-search results into a Select2 via the remote-data URL.
