Pretty Checkbox Radio (pcr) restyles Drupal's default checkbox and radio inputs into button-friendly "pretty" elements, both as an entity field widget and as Better Exposed Filters (BEF) exposed-filter widgets.

---

The module ships no configuration UI, permissions, or config schema; it works entirely by attaching a `#process` callback and a custom theme. `hook_element_info_alter()` adds `PrettyElement::process` to the `checkbox`, `radio`, `checkboxes`, and `radios` render elements, and any element carrying `#pretty_option = TRUE` gets rewritten: its `#theme` becomes `elements__pretty_options`, its `#title_display` is hidden, and the `pcr/pretty_elements` CSS library (`css/pretty_elements.css`) is attached. The flag is set in three ways: the `options_pretty` field widget (`PrettyOptionsWidget`, extending core `OptionsButtonsWidget`) for `boolean`, `list_string`, `list_integer`, `list_float`, and `entity_reference` fields chosen on *Manage form display*; and two BEF widget plugins, `pretty_bef` (`PrettyCheckboxesRadios` extending BEF's `RadioButtons`) and `pretty_single_bef` (`PrettySingleElement` extending BEF's `Single`), chosen per exposed filter in a View. Two Twig templates (`elements--pretty-options.html.twig`, `form-element--pretty-element.html.twig`) plus a `hook_theme_suggestions_form_element_alter` render the label as a clickable button wrapping the (visually hidden) input. Requires core `options` and the `better_exposed_filters` module (>=6.0.3 || >=7.0.0).

---

- Turn a boolean field's single checkbox into a styled on/off toggle button on a node edit form.
- Render a List (text) single-select field as a row of pretty radio buttons instead of a dropdown.
- Render a multi-value List (integer) field as pretty checkbox buttons.
- Style an entity-reference field's option buttons as pretty toggle buttons.
- Replace a View's exposed radio-button filter with the `pretty_bef` button widget.
- Replace a View's exposed checkboxes filter with pretty button-style checkboxes via BEF.
- Convert a single on/off exposed filter into a pretty toggle with the `pretty_single_bef` widget.
- Give faceted/exposed search filters a modern segmented-button look without custom CSS.
- Provide a consistent button UI for yes/no publishing or status fields.
- Improve touch-target size for option selection on mobile forms.
- Offer a visually clear "pick one" radio group for survey-style content fields.
- Present taxonomy or list options as tappable chips/buttons in an exposed filter.
- Hide the raw input while keeping it accessible and clickable through its label.
- Restyle checkboxes/radios site-wide by setting `#pretty_option` on custom form elements.
- Apply pretty buttons to a Layout Builder or block form exposed filter.
- Standardize option-widget styling between content forms and Views exposed filters.
- Swap in pretty buttons on an existing field by changing only the *Manage form display* widget.
- Attach the lightweight `pretty_elements` CSS library only where the widget is used.
- Use pretty radios for a "featured / not featured" boolean without a dropdown.
- Build filter toolbars for catalog/listing Views with button-style exposed filters.
- Give editors a clearer multi-select experience for controlled-vocabulary list fields.
