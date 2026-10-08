# webform_jqueryui_datepicker — agent start

DEPRECATED (`lifecycle: deprecated`; jQueryUI is unmaintained). Adds a jQueryUI calendar popup to Webform date/datetime elements via a `#datepicker` property. Depends on `webform` + `jquery_ui_datepicker`. Prefer native HTML5 date inputs on new sites. No config UI, permissions, or schema.

Key source (read directly — shorter than any summary):
- `src/Hook/WebformJqueryuiDatepickerHooks.php` — attaches the datepicker behavior to date elements.
- `js/webform_jqueryui_datepicker.element.js`, `css/webform_jqueryui_datepicker.element.css`, `images/elements/date-calendar.png` — picker assets.
- `webform_jqueryui_datepicker.libraries.yml` — library definition.
