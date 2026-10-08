# Frontend behavior

Library `maxlength/maxlength` (`maxlength.libraries.yml`): `js/maxlength.js` +
`css/maxlength.css`, depending on `core/drupal`, `core/once`, `core/jquery`.

How it attaches:
- `hook_element_info_alter()` adds `MaxLengthCallbacks::maxlengthPreRender` and
  `::processElement` to `textfield`, `textarea`, and `text_format` elements.
- The widget form alters (`hook_field_widget_single_element_form_alter`) set
  `#maxlength_js`, a `data-maxlength` attribute, and the `maxlength_js_label`
  message on the element (and on the summary / link title sub-elements).
- Pre-render (`MaxLengthCallbacks::maxlengthPreRender`) adds the `maxlength` CSS
  class and attaches the library when `data-maxlength > 0`.
- Hard limit adds the `maxlength_js_enforce` class (`processElement`), which the JS
  uses to block input past the limit; soft limit lets the count go negative.

Countdown message tokens: `@limit` (the max), `@remaining` (chars left), `@count`
(chars typed) are replaced live. Default:
`Content limited to @limit characters, remaining: <strong>@remaining</strong>`.

CKEditor 5: `hook_library_info_alter()` adds
`ckeditor5/internal.drupal.ckeditor5` as a dependency when the `ckeditor5` module
is enabled, so the counter works inside the rich-text editor. No templates or theme
hooks are defined — styling is via the `maxlength` CSS class.
