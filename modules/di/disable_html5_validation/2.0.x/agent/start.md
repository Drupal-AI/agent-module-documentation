<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable HTML5 validation — agent index

One `hook_form_alter()` that sets `$form['#attributes']['novalidate'] = 'novalidate'` on **every**
form, disabling the browser's native HTML5 client-side validation site-wide. Drupal server-side
validation is unchanged. No config, no settings form (`configure: null`), no permissions, no
schema, no services, no plugins.

- **What it does, the exact attribute, and how to exclude one form** →
  [mechanism.md](mechanism.md)

Key fact: the entire module body is
`function disable_html5_validation_form_alter(&$form, FormStateInterface $form_state, $form_id) { $form['#attributes']['novalidate'] = 'novalidate'; }`.
To re-enable validation on a single form, add a module that unsets
`$form['#attributes']['novalidate']` in an `#after_build` callback (reliable regardless of
module alter ordering) — see [mechanism.md](mechanism.md#excluding-a-single-form-re-enable-html5-validation).
