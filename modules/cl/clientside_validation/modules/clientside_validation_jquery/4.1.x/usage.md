Clientside Validation jQuery is the engine submodule of Clientside Validation: it loads the jQuery Validate plugin and turns the `data-rule-*` / `data-msg-*` attributes written by the base module into live, before-submit validation with inline error messages.

---

This submodule depends on `clientside_validation` and does the actual client-side enforcement. It ships the `jquery.validate` (and `jquery.validate.additional`) Drupal libraries plus glue JS (`cv.jquery.validate.js`), and — via `hook_clientside_validation_validator_info_alter()` — attaches `clientside_validation_jquery/cv.jquery.validate` to every validator so the engine is present wherever a rule is. The jQuery Validate library itself is resolved by `hook_library_info_alter()`: it prefers a local copy at `/libraries/jquery-validation/dist/`, falls back to a copy inside the module, and otherwise loads from a configurable CDN (`use_cdn` / `cdn_base_url`, default jsDelivr 1.21.0). A Drush command set manages that library: `clientside_validation_jquery:library-download` (alias `cvjld`), `:library-status` (`cvjls`), and `:library-remove` (`cvjlr`). A settings form at `/admin/config/user-interface/clientside-validation-jquery-settings` (route `clientside_validation_jquery.settings_form`, config object `clientside_validation_jquery.settings`) controls CDN use, whether all AJAX forms are validated (`validate_all_ajax_forms` — forms with class `cv-validate-before-ajax`), forcing validation on blur, and forcing native HTML5 validation first. It also adds two extra validator plugins — `pattern` (regex) and `equal_to` (field-matches-field) — integrates with CKEditor (`hook_js_alter`) and Inline Form Errors, and pushes a set of default translated messages and config to `drupalSettings` on every page.

---

- Load the jQuery Validate engine so base-module validation attributes are actually enforced.
- Show inline, before-submit error messages on Drupal forms.
- Serve the jQuery Validate library from a local `libraries/` copy for privacy/offline use.
- Fall back to a CDN copy of jQuery Validate when no local library is present.
- Point the CDN at a specific version by setting `cdn_base_url`.
- Download the jQuery Validate library with `drush cvjld` (no manual unzip).
- Check whether the library is installed with `drush cvjls`.
- Remove the downloaded library with `drush cvjlr`.
- Validate all AJAX forms before submit by adding class `cv-validate-before-ajax` (setting `validate_all_ajax_forms`).
- Validate a `#pattern` regex on a textfield in the browser (`pattern` validator).
- Require two fields to match, e.g. password confirmation (`equal_to` validator).
- Validate CKEditor-backed rich-text fields (CKEditor integration).
- Route client-side messages through Inline Form Errors when that module is enabled.
- Force validation to fire on blur/focusout (`force_validate_on_blur`).
- Run native HTML5 validation before the jQuery layer (`force_html5_validation`).
- Deploy the engine settings as configuration between environments (`clientside_validation_jquery.settings`).
- Customise the CDN base URL for an air-gapped or corporate mirror.
- Provide translated default messages (required, email, url, number, maxlength, etc.) via `drupalSettings`.
- Add the engine automatically to every form element that carries a validation rule.
- Ensure the engine's JS loads after CKEditor so rich-text widgets validate correctly.
- Gate access to the settings form with the `administer site configuration` permission.
