Multiselect provides a two-box "Available options / Selected options" field widget (and a matching `multiselect` Form API element) that lets editors move choices between an unselected list and a selected list instead of using a native multi-select or a column of checkboxes.

---

Multiselect ships a field widget plugin (`id: multiselect`, extending core's `OptionsWidgetBase`) usable on `list_string`, `list_float`, `list_integer`, and `entity_reference` fields, plus a reusable Form API render element (`#type => 'multiselect'`, a subclass of core's `Select` element) for custom forms. The widget renders two `<select multiple>` boxes side by side — available options on the left, selected on the right — with **Add** and **Remove** buttons; a small JS library (`multiselect/drupal.multiselect`, jQuery + once + drupalSettings) moves options between them and keeps a hidden real select in sync on submit. A single global setting, the pixel **width** of the select boxes, lives in the config object `multiselect.settings` at key `multiselect.widths` (default `250`) and is edited on the admin form at `/admin/config/content/multiselect`; it is pushed to the browser via `drupalSettings.multiselect.widths`. There are no per-field widget settings beyond core's `size`, no permissions, no Drush, and no plugin type others extend — it is a widget/element pair with one global width setting.

---

- Give editors a friendlier way to pick many taxonomy terms on an entity-reference field.
- Replace a tall column of checkboxes on a List (text) field with a compact two-box selector.
- Let content authors move roles/users into a selected list on a user-reference field.
- Provide add/remove multi-selection on a List (integer) field of numeric options.
- Use it on a List (float) field where several values are commonly chosen at once.
- Swap the default multi-value select widget for the two-box UI on any options field.
- Standardise multi-selection UX across content types by choosing Multiselect on each field's Manage form display.
- Offer a clearer "chosen vs available" view when a field has dozens of allowed values.
- Embed a `#type => 'multiselect'` element in a custom module's form to reuse the widget outside fields.
- Set a consistent select-box width site-wide via the single `multiselect.widths` setting.
- Widen or narrow the boxes (e.g. 250px → 400px) to fit long option labels.
- Reduce mis-clicks compared to ctrl-click native multi-selects for non-technical editors.
- Present available and already-selected options as two clearly labelled lists.
- Let editors add all remaining options or remove selected ones with a button click.
- Deploy the width setting as exported configuration (`multiselect.settings`).
- Use on an entity-reference field pointing at nodes to build a curated related-content list.
- Provide a mobile-friendlier multi-select (the module ships add/remove button icons incl. RTL/mobile).
- Keep multi-value editing accessible on fields that allow unlimited values.
- Apply the widget to media-reference or file-reference options-style fields.
- Give a data-entry team a quicker workflow for assigning many categories at once.
- Theme the two boxes via the `multiselect.html.twig` template if custom markup is needed.
- Migrate a legacy CCK "multiselect" field to the Drupal 9/10/11 equivalent widget.
- Reuse the selected-order behaviour (the widget preserves the order values were selected in).
