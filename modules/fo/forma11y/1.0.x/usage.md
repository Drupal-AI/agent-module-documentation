<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forma11y improves the accessibility of Drupal forms by suppressing browser-native HTML5 validation so that Drupal's server-side, inline form errors — which are programmatically associated with their fields — are what users (and assistive technology) receive.
---
Native HTML5 validation bubbles are not consistently exposed to screen readers and can pre-empt Drupal's own error handling. The module implements `hook_form_alter()` to add the `novalidate` attribute to every form and attaches a small JS library; combined with core's required `inline_form_errors` module, validation errors are rendered inline and linked to inputs via ARIA, giving a consistent, accessible error experience across browsers and assistive tech.

Setup is zero-configuration: enable the module (and its `inline_form_errors` dependency) and every form immediately gets `novalidate` plus the helper library. There are no settings, routes, or permissions.
---
- Disable inconsistent native HTML5 validation bubbles
- Route validation through Drupal's accessible inline errors
- Associate error messages with their fields for screen readers
- Improve WCAG conformance of site forms
- Provide a consistent error UX across browsers
- Apply novalidate to all forms automatically
- Pair with core inline_form_errors for ARIA-linked errors
- Improve accessibility of the login/registration forms
- Improve accessibility of Webforms and content forms
- Attach the forma11y helper JS library
- Zero-configuration accessibility improvement
- Support assistive-technology users completing forms- Reduce reliance on browser-specific validation UI
- Ensure error text is announced by assistive technology
- Standardise error handling on multi-step forms
- Complement server-side validation with accessible display
