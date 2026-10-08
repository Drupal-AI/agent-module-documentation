<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Hidden provides "Hidden field" form widgets that render core number and plain-text fields as HTML `input[type='hidden']` elements, so the value is submitted with the form but never shown or editable by hand.

---

The module adds three field widget plugins that all carry the label "Hidden field" and each extends the matching core widget: `field_hidden_string_textfield` (for `string` / Text plain, extends `StringTextfieldWidget`), `field_hidden_string_textarea` (for `string_long` / Text plain-long, extends `StringTextareaWidget`), and `field_hidden_number` (for `integer`, `decimal`, `float`, extends `NumberWidget`). Selected on a bundle's *Manage form display* page, each widget calls its parent to build the normal element and then changes the value element's `#type` to `hidden`, adds a CSS class (`field-hidden-string`, `field-hidden-string-long`, `field-hidden-integer`, `field-hidden-decimal`, `field-hidden-float`), and attaches the `field_hidden/drupal.field_hidden` library to hide any extra rows. Crucially it is *not* the same as choosing "- Hidden -" in Manage form display: "- Hidden -" removes the field from the form entirely (leaving it uneditable and unsubmitted), whereas Field Hidden keeps the value in the submitted form as a hidden input, so a default or programmatically set value round-trips through save. There is one exception baked in: on the field's own settings form (`field_ui_field_edit_form`) the element is left visible so you can still enter a default value. The module has no configuration page, no config schema, no permissions, and no dependencies beyond core; it only formatted text is unsupported because core's text-processing feature can't be represented in a hidden input.

---

- Keep a computed or default numeric value on a node form without letting editors change it.
- Carry a plain-text token/reference value through an entity form as a hidden input.
- Prefill an integer field with a default and submit it invisibly on every save.
- Store a hidden "source system id" string on imported content that editors shouldn't edit.
- Pass a fixed decimal (e.g. a rate) with the form while hiding it from the UI.
- Hide a long plain-text payload (`string_long`) field but still submit its stored value.
- Distinguish "present but hidden" from core's "- Hidden -" (which drops the field entirely).
- Keep a field editable-by-default value that survives form submission without user input.
- Provide a hidden float field for a calculated weight/score kept out of the editor's way.
- Target the hidden element with the `field-hidden-integer` CSS class for custom JS.
- Populate a hidden string field via JavaScript before submit (form still carries it).
- Show the value only on the field settings form (for defaults) but hide it on entity forms.
- Keep a machine-only reference number attached to user profiles invisibly.
- Submit a fixed campaign/code string with every node of a type without a visible widget.
- Hide an internal sort/order integer while still writing it on save.
- Retain a legacy identifier field on migrated content without cluttering the edit form.
- Provide a hidden decimal price component that a formula sets but users never see.
- Keep a hidden per-item value on a multi-value field (extra rows hidden via the library).
- Avoid writing a custom widget plugin just to make a core field a hidden input.
- Standardise "hidden but submitted" behavior across integer, decimal, and float fields.
- Attach a hidden plain-text flag to media/taxonomy entities via their form display.
- Keep a default value editable in field settings yet invisible on content forms.
- Ensure a field's default value is actually saved (unlike "- Hidden -", which omits it).
