DEPRECATED. Adds a jQueryUI calendar datepicker popup to Webform date and datetime elements.

---

Webform jQueryUI Datepicker is a deprecated submodule that restores the classic jQueryUI calendar popup on Webform's date and datetime elements via a `#datepicker` property. It implements Webform element hooks (in `src/Hook`) to attach the datepicker behavior, ships the JavaScript, CSS, and a calendar icon, and pulls in the `jquery_ui_datepicker` contrib module. Because jQueryUI is no longer maintained, the module is marked `lifecycle: deprecated`; modern sites should rely on the native HTML5 date input (the browser's built-in date picker) instead. It exists for backwards compatibility with forms that were configured to use the jQueryUI picker before it was removed from core. No config UI, permissions, or schema of its own.

---

- Restore the jQueryUI calendar popup on date fields (legacy sites).
- Maintain existing forms that enabled `#datepicker`.
- Provide a consistent date picker across browsers that lack native ones.
- Keep older webforms rendering their date UI during an upgrade window.
- Migrate away from: locate forms still using the jQueryUI datepicker.
- Reference how the picker attaches to date/datetime elements.
- Test backwards compatibility after upgrading Webform.
- Audit a site for deprecated jQueryUI dependencies.
- Support date entry UX expected by an older theme.
- Understand the hook that wires the datepicker behavior.
- Compare against the native HTML5 date input approach.
- Document the deprecation path for editors and developers.
- Verify the `jquery_ui_datepicker` dependency is present.
- Plan removal by finding each `#datepicker` usage in config.
- Provide the calendar icon/styling expected on legacy forms.
- Debug date-format handling with the jQueryUI picker.
