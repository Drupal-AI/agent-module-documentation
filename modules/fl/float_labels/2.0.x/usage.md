Float Labels applies configurable, JavaScript-enhanced floating CSS labels to selected Drupal forms, so a field's label sits inside the field like a placeholder and animates above it on focus or when the field has a value.

---

Float Labels is a front-end form-theming module with no external dependencies. You enable it, then visit its settings page (`/admin/config/user-interface/float-labels`) to declare which forms it should act on by matching form IDs (plain strings or PCRE regex, one per line), optionally excluding others. Within each matched form it narrows down which fields are affected using CSS selector include/exclude lists. At render time the module's `hook_element_info_alter()` tags matched text-like elements (`textfield`, `textarea`, `tel`, `email`, `url`, `password`, `password_confirm`, and optionally `select`) with `float-labels-*` classes and attaches `drupalSettings` plus the `float_labels/float_labels` asset library. The bundled jQuery behavior (`Drupal.behaviors.floatLabels`) then wraps each field, moves its `<label>` into a floating label, removes the redundant `placeholder`, and toggles focus/filled state classes that the CSS animates. Options include marking required fields with a "*" and, for select fields, replacing the empty option's text with the field label via a configurable template. All styling lives in `css/float_labels.css`, which you are meant to override in your own theme. The settings form is gated by the dedicated `administer float labels` permission.

---

- Enable floating labels on the site-wide login form (`user_login_form`) for a modern, compact sign-in UI.
- Apply floating labels to the user registration form (`user_register_form`) so labels double as placeholders until typed.
- Style the contact form (`contact_message_*_form`) with animated labels to save vertical space.
- Add floating labels to a search block form while excluding the submit button via CSS selectors.
- Use a regex form-ID match (e.g. `/^comment_/`) to apply floating labels to all comment forms at once.
- Match every node edit form with a regex like `/_node_form$/` while excluding admin-only forms.
- Target only specific fields inside a matched form using the "Included selectors" list (any valid CSS selector, including `*`).
- Exclude particular fields (e.g. `#edit-mail`) from floating-label treatment using the "Excluded selectors" list.
- Turn a plain placeholder-based design into an accessible one, since Float Labels keeps a real associated `<label>` element rather than relying on the `placeholder` attribute.
- Mark required fields with a trailing "*" automatically by enabling the "Mark required fields" option.
- Replace a select field's empty "- Select -" option text with the field's own label by enabling select support.
- Customize the select placeholder wording with a template such as `Choose %s` or `- %s -` via the template setting.
- Apply consistent floating-label styling across many custom module forms by listing their form IDs.
- Provide a lightweight, dependency-free alternative to heavier UI kits for form label animation.
- Roll out floating labels progressively by adding form IDs to the include list one at a time.
- Combine a broad include regex with a targeted exclude list to opt a few problematic forms out.
- Override or extend `css/float_labels.css` in your theme to match brand colors and animation timing.
- Improve mobile form UX where screen space is tight by collapsing labels into fields until focus.
- Apply floating labels only to text-like inputs while leaving checkboxes, radios, and buttons untouched (the JS ignores buttons and non-select inputs by design).
- Use per-form control by setting `#float_labels` (TRUE/FALSE) on a specific form or element in a custom module to force-include or force-exclude it without touching global config.
- Standardize the look of email/telephone/URL fields across the site since those element types are covered by default.
- Give password and password-confirm fields floating labels for a cleaner account-settings page.
