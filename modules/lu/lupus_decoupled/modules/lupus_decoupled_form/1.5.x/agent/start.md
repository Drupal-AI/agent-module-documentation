<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Form (lupus_decoupled_form) — agent index

Submodule of **lupus_decoupled**. API for rendering **Drupal forms as custom elements**.
Version **1.5.1**. Core `^10 || ^11`.

**Why it matters:** a Drupal form is an element tree with server-side validation, constraints,
`#states`, AJAX callbacks and CSRF protection — not markup. A front end that rebuilds the markup
and posts JSON reimplements all of that, usually incompletely, and the gaps are where bad data and
security problems get in. Here submission goes back through Drupal's form API, so validation and
CSRF are Drupal's.

**Base for `lupus_decoupled_user_form`, `_contact` and `_webform`.** Use this API to expose a
custom module's form rather than inventing an endpoint.