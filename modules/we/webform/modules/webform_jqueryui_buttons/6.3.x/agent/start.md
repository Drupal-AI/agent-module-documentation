# webform_jqueryui_buttons — agent start

DEPRECATED (`lifecycle: deprecated`; jQueryUI is unmaintained). Provides button-group select elements. Depends on `webform` + `jquery_ui_button`. Prefer standard radios / CSS on new sites. No config UI, permissions, or schema.

Key source (read directly — shorter than any summary):
- `src/Plugin/WebformElement/WebformButtons.php` — `webform_buttons` element (`OptionsBase`).
- `src/Plugin/WebformElement/WebformButtonsOther.php` — `webform_buttons_other` (adds "Other…").
- `src/Element/WebformButtons.php`, `src/Element/WebformButtonsOther.php` — render elements.
- `js/webform_jqueryui_buttons.element.js` — jQueryUI buttonset behavior.
