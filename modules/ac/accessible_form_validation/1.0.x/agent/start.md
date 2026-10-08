<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Form Validation (accessible_form_validation) — agent index

Client-side only. Replaces the browser's native HTML5 validation popups with inline, themeable,
screen-reader-perceivable error messages. Version **1.0.4**, core `^10 || ^11`, no non-core
dependencies. No permissions of its own (config gated by core `administer site configuration`), no
Drush, no plugin types.

- **Settings (`accessible_form_validation.settings`): the two per-theme toggles, the custom
  error-selector, and exactly when the library is attached** →
  [configure/settings.md](configure/settings.md)

## Mechanism (what the code actually does)

- `accessible_form_validation_form_alter()` attaches the library
  `accessible_form_validation/accessible_form_validation` when the config toggle for the *active*
  theme is on: `default_theme_enabled` when active theme == `system.theme:default`,
  `admin_theme_enabled` when active theme == `system.theme:admin`. Always adds cache tag
  `config:accessible_form_validation.settings`.
- The error-container class is passed to JS via
  `drupalSettings.accessibleFormValidation.errorMessageSelector`: on the default theme from
  `default_theme_error_message_selector` if set; otherwise (default or admin theme) forced to
  `form-item__error-message` when the active theme is `claro` or `gin`. JS default when nothing is
  set is `form-item--error-message`.
- Library (`assets/js/accessible_form_validation.js`, `Drupal.behaviors.accessibleFormValidation`,
  deps `core/drupal`, `core/once`, `core/drupalSettings`):
  - `once()` over every `form` that has ≥1 `*:required` element → sets attribute
    `novalidate="novalidate"` and binds a `submit` handler. Forms with no required fields are
    skipped.
  - `once()` over `input, textarea, select` → for required ones binds `input`, `blur`
    (only after a real pointer/key interaction, tracked via `data-afv-user-interacted`), and, for
    Choices.js widgets (class `webform-choices`), `change` + `focusout`. Initialises
    `aria-invalid="false"`.
  - Validation uses the Constraint Validation API: `element.checkValidity()`;
    invalid → `setInputAsInvalid` sets `aria-invalid="true"`, input classes `is-invalid error`,
    `.form-item` classes `form-item--error was-validated`, `<label>` class `has-error`, and injects
    an error `<div>` (class = the container selector, plus `invalid-feedback`) whose text is
    `input.validationMessage` via `innerText`, inserted before `.form-item__description` if present.
    valid → `setInputAsValid` reverses those and removes the error `<div>`.
  - On submit: revalidates all `*:required`, and if `form.checkValidity()` is false calls
    `event.preventDefault()` and focuses the first `input:invalid, textarea:invalid, select:invalid`.

## Accuracy notes for agents (do not overstate)

- It sets **`aria-invalid`** but does **NOT** set `aria-describedby` — the inline message is not
  programmatically associated with the input by that attribute.
- It does **NOT** build or ARIA-live-announce an error **summary**; accessibility rests on focus
  movement to the first invalid field plus the per-field inline message text.
- Error text is the browser's own `validationMessage` (localised by the browser, not by Drupal).
- Only fields with the HTML `required` attribute are wired; non-required constraints are not
  actively watched between submits.
- Core's form-error accessibility has improved over recent releases — verify the remaining gap on the
  specific core version.
