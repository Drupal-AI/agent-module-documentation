<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Georgian Personal Number (webform_gpn) — agent index

**A Webform element for a Georgian Personal ID number: 11-digit (`^\d{11}$`) validation with an input mask.**

- **Version:** 1.0.x (1.0.0-alpha1) — core `^10 || ^11`; depends on `webform` (^6.2).
- **Elements:** render element `\Drupal\webform_gpn\Element\WebformGeorgianPersonalNumber` (extends `Textfield`, applies `webform/webform.element.inputmask`); Webform plugin `webform_georgian_personal_number` (category "Custom") with an "Error message" setting.
- **Validation:** local `preg_match('/^\d{11}$/')`; sets the configured error message on failure.
- **Use:** add the "Georgian Personal Number" element to a webform; no config UI.
- **Security:** self-contained input element — no external calls, no secrets, no routes; validation is a local regex only.
