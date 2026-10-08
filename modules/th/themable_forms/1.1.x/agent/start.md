<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Themable Forms — agent index

Adds per-element / per-form Twig **theme suggestions** for the `form_element` and
`form_element_label` theme hooks, and attaches `#form_id` to every form element so those
suggestions have the form context. No configuration, no configure route (`configure: null`), no
permissions, no schema, no services, no plugins — enabling it just makes the suggestions available.

- **The exact suggestions, the template file names, and how to use them** →
  [theming/suggestions.md](theming/suggestions.md)

Key facts:
- `hook_form_alter()` recursively sets `#form_id` on every element (form id like `node_article_form`).
- `form_element` suggestions: `form_element__type__<type>`, `form_element__form_id__<form_id>`,
  `form_element__<form_id>__<type>`.
- `form_element_label` suggestions: `form_element_label__type__<type>`,
  `form_element_label__form-id__<form_id>`, `form_element_label__<form_id>__<type>`.
- You consume them by adding matching Twig templates in your theme; most specific wins.
