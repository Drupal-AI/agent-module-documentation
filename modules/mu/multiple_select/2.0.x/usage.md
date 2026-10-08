Multiple Select adds a "Select All / Uncheck All" master checkbox above configured multi-value checkboxes fields on entity edit forms, so editors can tick or clear every option at once.

---

The module has no field type or widget of its own. Instead it targets existing multi-value fields whose form-display widget is "Check boxes" (the core `options_buttons` widget rendering `#type => checkboxes`). On a global admin form (`/admin/config/content/multiple-config`) you choose, per content-entity bundle, which of its `list_string` / `entity_reference` fields should get the helper. Those choices are stored as a single JSON string in the `multiple_select.settings` config object under the key `table`, mapping `"<entity_type>-<bundle>"` to an array of field machine names. At form-build time `hook_form_alter()` (wired for node, media, taxonomy_term and site_setting_entity forms) reads that config, and for each registered field that is actually rendered as `checkboxes` it injects an extra `checkall<field>` checkbox just above the field and attaches the `multiple_select/selectall` JS library. The JavaScript toggles every child checkbox when the master is clicked, and re-syncs the master when individual boxes change. Its default value is pre-checked when all options are already selected on an existing entity. It also cooperates with Field Group, moving the master checkbox inside a field-group container when the field lives in one.

---

- Add a "select all" master toggle to a multi-value checkboxes field on the Article edit form.
- Let editors tick every term of a taxonomy checkboxes field in one click.
- Clear all selected options at once on a long list of category checkboxes.
- Enable the helper for a `list_string` field (allowed-values checkboxes) on a content type.
- Enable it for an `entity_reference` field rendered as checkboxes (e.g. reference to tags).
- Turn on the helper for several fields of the same bundle simultaneously.
- Configure which node bundles expose the helper from one central admin page.
- Apply the helper to Media entity edit forms as well as nodes.
- Apply the helper to taxonomy term edit forms.
- Apply the helper to Site Settings entity forms (when the `site_settings` module is present).
- Pre-check the master toggle automatically when an existing entity already has all options selected.
- Speed up data entry on forms where authors usually want "all of the above".
- Reduce mis-clicks on wide checkbox grids by offering an all/none control.
- Keep the helper scoped to just the fields you list, leaving other checkboxes untouched.
- Store the field selection as exportable config (`multiple_select.settings:table`) for deployment.
- Move the master checkbox inside a Field Group container so it stays with its field.
- Gate access to the configuration page with the "access multiple select config page" permission.
- Offer an all/none control without writing a custom Form API element or widget.
- Give content teams a consistent bulk-select UX across many bundles.
- Toggle the helper on or off for a field by editing the config `table` map.
- Provide a friendlier UI for fields that were switched to the "Check boxes" widget.
- Combine with allowed-values lists so long option sets become quick to fill.
- Use on membership/permission-style checkbox lists where "select all" is common.
- Help editors quickly invert a selection (select all, then untick a few).
