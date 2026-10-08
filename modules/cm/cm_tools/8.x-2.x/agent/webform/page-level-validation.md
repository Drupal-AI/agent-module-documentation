<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform page-level validation handler

A Webform handler that raises a **form-wide** validation error (not attached to any single element),
so you can block submission with a custom message based on Webform **Conditions**. Requires the
contrib **`webform`** module at runtime (the class extends `WebformHandlerBase`); cm_tools declares
no hard dependency, so the handler only loads where `webform` is installed.

## Plugin

`Plugin/WebformHandler/CmToolsPageLevelValidation` — id `cm_tools_page_level_validation`, label
"Page level validation", category "Validation". `CARDINALITY_UNLIMITED` (add several per form),
`RESULTS_IGNORED`, `SUBMISSION_OPTIONAL`.

## Configuration

`defaultConfiguration()`: `message` (string, required) and `pages_to_set_on` (array of wizard-page
element keys).

`buildConfigurationForm()`:

- `message` — a `webform_html_editor` field, the error text shown on the form. Its description tells
  the admin to use the handler's **Conditions** tab to decide *when* the error fires.
- `pages_to_set_on` — checkboxes of the form's wizard-page elements (built by scanning
  `getElementsInitializedAndFlattened()` for `#type == 'webform_wizard_page'`). Only shown when the
  form has more than one wizard page (`#access => count(...) > 1`). Lets you defer the error until
  the visitor reaches the page(s) where the relevant fields live.

`submitConfigurationForm()` stores only the checked page keys (`array_keys(array_filter(...))`).

## Validation logic

`validateForm()`:

```php
$current_page = $form_state->has('current_page') ? $form_state->get('current_page') : '';
if (empty($this->configuration['pages_to_set_on'])
    || in_array($current_page, $this->configuration['pages_to_set_on'], TRUE)) {
  $form_state->setErrorByName('', WebformHtmlHelper::toHtmlMarkup($this->configuration['message']));
}
```

- Empty page list → error can fire on any page; otherwise only on the selected wizard page(s).
- The handler intentionally does **no condition evaluation itself** — it relies on the admin having
  set the handler's Webform Conditions so it only runs when appropriate, then unconditionally sets
  the whole-form error (`setErrorByName('')`).
- The message is admin-authored config, passed through `WebformHtmlHelper::toHtmlMarkup()`.

## Summary template

`templates/webform-handler-cm-tools-page-level-validation-summary.html.twig` (registered by
`hook_theme()` as `webform_handler_cm_tools_page_level_validation_summary`) renders the handler's
one-line summary on the Webform handlers list: a 50-char-truncated message and the "Only on pages"
list.

## How to use

1. On a webform, **Settings → Emails/Handlers → Add handler → Page level validation**.
2. Enter the error **message**; optionally restrict to specific wizard pages.
3. On the handler's **Conditions** tab, set the trigger conditions — the error appears whenever
   those conditions are met (and, if set, the visitor is on a selected page), blocking submission.
