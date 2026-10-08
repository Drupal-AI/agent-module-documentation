<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Popup Field Group adds a "Popup" field-group formatter to the Field Group module, so the fields you place inside a group are rendered hidden and opened in a jQuery-UI dialog/popup via an "Open popup" link.

---

The module ships a single `field_group` `FieldGroupFormatter` plugin with id `popup`
(supported contexts: `form` and `view`), extending `FieldGroupFormatterBase`. You add it
like any field group: on an entity's *Manage display* or *Manage form display*, click
"Add group", pick "Popup", then place fields inside it. At render time the formatter's
`process()`/`preRender()` wraps the group's children in a `container` that is
`display:none;`, prepends an `<a class="popup-field-group-open-popup" data-target="…">`
link, and attaches the `popup_field_group/core` library (depends on `core/once` and
`core/drupal.dialog`) plus `drupalSettings` describing the dialog. Its JS opens the hidden
content in a Drupal dialog. All configuration is per-group and stored in the display config
entity's `third_party_settings.field_group.<group_name>` alongside `format_type: popup` and
a `format_settings` map with three sections: `popup_link` (show/text/classes for the
trigger), `popup_labels` (title, close button text), and `popup_settings` (modal,
dialog_class, close_on_escape, height/width family, position_horizontal/vertical,
append_to), plus an optional `extra_css` (shown only when the System Stream Wrapper module
is installed). There is no admin settings page, permission, entity, or Drush command of its
own; it requires the Field Group module.

---

- Put a long set of "advanced" fields behind an "Open popup" link on the node edit form to declutter it.
- Show supplementary content (specs, fine print) in a modal on the rendered node display.
- Group rarely used settings into a popup so editors see a shorter main form.
- Present an image gallery's metadata fields inside a dialog instead of inline.
- Add a "More details" modal to a product display without custom theming.
- Make a group modal (blocking) or non-modal (floating) via the `modal` setting.
- Customise the trigger link text and CSS classes (e.g. style it as a button).
- Set a dialog title and a custom close-button caption.
- Control dialog height/width and min/max dimensions per group.
- Position the dialog (left/center/right, top/center/bottom) on screen.
- Close the dialog on the Escape key, or disable that behavior.
- Append the dialog markup to a specific DOM element via a CSS selector.
- Hide the trigger link and open the popup from your own custom control targeting its `data-target` id.
- Reuse the same popup group across content types by exporting the display config.
- Wrap terms-and-conditions fields in a modal on a form.
- Show a preview/help panel in a popup on complex admin forms.
- Add per-group custom CSS files (with System Stream Wrapper) for bespoke dialog styling.
- Keep form-mode-specific popups (popup on the default form but not another).
- Use on both form and view displays since the formatter supports both contexts.
- Reduce scroll length on data-heavy edit forms by collapsing sections into dialogs.
