IEF Complex Widget Dialog (ief_popup) makes the Inline Entity Form **Complex** widget open its add / edit / duplicate / remove / add-existing sub-forms as a centered modal popup (with a styled title bar and overlay) instead of expanding inline on the host form, toggled per widget by a single third-party-settings checkbox.

---

The module is a thin CSS/JS + form-alter layer over `inline_entity_form`'s `InlineEntityFormComplex` widget. On the *Manage form display* widget settings it adds one third-party setting checkbox, **"Enable Popup for IEF"** (`third_party_settings.ief_popup.ief_popup_enabled`), via `hook_field_widget_third_party_settings_form()`, and reflects it in the settings summary. When enabled, several IEF form-alter hooks (`hook_inline_entity_form_entity_form_alter`, `hook_field_widget_single_element_inline_entity_form_complex_form_alter`) route the IEF sub-form through `ief_popup__process_ief_form()`, which wraps it in jQuery-UI-dialog-style markup (`ief-popup-overlay`, `ief-popup-wrapper`, `ui-dialog` classes), builds a title bar with a close button, sets a contextual popup title per action (Add/Edit/Duplicate/View/Remove/existing), and an `#after_build` callback tags the action buttons (primary vs `ief-popup-cancel`). The frontend behaviour and styling come from the `ief_popup/ief_popup` library (`js/ief_popup.js`, `css/ief_popup.css`, deps `core/jquery`, `core/drupal`, `core/drupal.dialog`), attached site-wide via `hook_preprocess_page()`. It special-cases Layout Builder (`ConfigureBlockFormBase`) and derives parent titles for `node`, `block_content`, `taxonomy_term` and `user` host entities to render a friendlier "remove" confirmation. There is no config UI (`configure` null), no permissions, no schema — the only setting is the per-widget checkbox.

---

- Turn an Inline Entity Form Complex widget's add form into a modal popup instead of an inline block.
- Open the IEF edit form for an existing referenced entity in a dialog.
- Show the IEF duplicate form as a popup.
- Show the "Add existing" reference selection form in a popup.
- Present the remove/delete confirmation as a modal with a clearer message.
- Keep a long host form compact by moving nested entity editing into overlays.
- Improve UX for deeply nested referenced entities (paragraphs-like structures via IEF).
- Enable the popup only on specific fields/form modes by checking the box per widget.
- Use IEF popups inside Layout Builder block configuration forms (supported special case).
- Provide modal nested-entity editing without writing custom dialog JS.
- Give editors a focused, distraction-free space to fill in a child entity.
- Standardise nested-entity editing on jQuery-UI-dialog styling.
- Reduce vertical scrolling on content forms that embed multiple referenced entities.
- Show contextual popup titles (Add/Edit/Duplicate/Remove) so editors know which action they're in.
- Add a visible close ("X") control to cancel an IEF sub-form.
- Apply to node, block content, taxonomy term or user host-entity forms.
- Keep primary vs cancel action buttons visually distinct inside the dialog.
- Layer purely presentational modal behaviour on top of existing IEF configuration with no data-model change.
- Toggle the popup off again by unchecking the widget setting, reverting to stock inline IEF.
