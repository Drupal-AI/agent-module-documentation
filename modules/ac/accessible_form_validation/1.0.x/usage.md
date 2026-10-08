<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accessible Form Validation swaps the browser's native HTML5 validation bubbles for inline, themeable, screen-reader-perceivable error messages. It attaches a JS behaviour that disables native validation, re-runs the checks through the Constraint Validation API, and marks failing fields with `aria-invalid="true"` and an inline message; enable it per theme (front-end and/or admin) from one settings page.

---

The module works entirely client-side and hangs off `hook_form_alter`. When enabled for the active theme (`default_theme_enabled` when the active theme is the site default, `admin_theme_enabled` when it is the admin theme), it attaches the library `accessible_form_validation/accessible_form_validation` — three tiny JS files' worth of behaviour depending on `core/drupal`, `core/once` and `core/drupalSettings` — and adds the cache tag `config:accessible_form_validation.settings`. The behaviour finds every form that contains at least one `*:required` element, sets `novalidate` on it so the browser's own popups never fire, and takes over validation itself. Per required input it listens on `input`/`blur` (plus `change`/`focusout` for Choices.js widgets, which carry the `webform-choices` class) and, on submit, calls `checkValidity()` on each field. A failing field gets `aria-invalid="true"`, the CSS classes `is-invalid error` (and its `.form-item` gets `form-item--error was-validated`, its `<label>` gets `has-error`), and an inline error container is created inside the `.form-item` — before the `.form-item__description` if present — holding the browser's own `input.validationMessage` text set via `innerText`, with class `invalid-feedback`. A passing field flips to `aria-invalid="false"`, gains `is-valid`, and its error container is removed. On a submit that fails overall, submission is prevented and focus moves to the first `:invalid` input/textarea/select. The error-container class defaults to `form-item--error-message`, but the module auto-switches it to `form-item__error-message` under Claro/Gin, and on the default theme you can override it with the `default_theme_error_message_selector` config value (a bare class name, no leading dot). Two accuracy notes for agents: this module sets `aria-invalid` but does **not** wire up `aria-describedby`, and it does **not** build or announce an ARIA-live error summary — it relies on focus movement plus the per-field inline message. Configuration lives at Configuration » User Interface » Accessible form validation (`/admin/config/user-interface/accessible-form-validation`, permission `administer site configuration`). Version 1.0.4, core `^10 || ^11`, no non-core dependencies. Core's own accessibility for form errors has improved across recent releases, so verify what this still adds on your specific core version.

---

- Replace native HTML5 validation popups with inline messages.
- Show validation errors that screen readers can perceive.
- Add `aria-invalid` to fields that fail client-side validation.
- Disable browser-native form validation via `novalidate` without losing checks.
- Move focus to the first invalid field on a blocked submit.
- Keep required-field error messages inside the field's `.form-item`.
- Turn a registration form's errors accessible.
- Turn a checkout form's errors accessible.
- Improve a contact form's error reporting.
- Improve a webform's client-side validation UX.
- Enable accessible validation only on the front-end theme.
- Enable accessible validation only on the admin theme.
- Enable it on both front-end and admin themes.
- Override the error-message container CSS class on the default theme.
- Get themeable error messages instead of un-styleable browser bubbles.
- Support Claro/Gin with the correct `form-item__error-message` container class.
- Add Choices.js / webform select validation feedback.
- Address an accessibility-audit finding about form validation.
- Convey validation errors by more than colour.
- Give live per-field validation on blur and input.
- Meet a public-sector or WCAG form-accessibility requirement.
- Reduce form abandonment for assistive-technology users.
