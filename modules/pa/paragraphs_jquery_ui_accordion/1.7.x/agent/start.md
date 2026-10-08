<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs jQuery UI Accordion — agent index

Renders a **multi-value Paragraphs reference field** as a jQuery UI accordion via one field
formatter. No admin settings page (`configure: null`), no permissions. Depends on
`paragraphs` + `jquery_ui_accordion` (core's bundled jQuery UI — no extra libraries to install).

- **Apply and configure the accordion formatter (all settings + drush example)** →
  [configure/formatter.md](configure/formatter.md)

Key facts: formatter id `paragraphs_jquery_ui_accordion_formatter`; applies only to
`entity_reference_revisions` fields that are multi-value and target `paragraph`
(`isApplicable()`); settings `bundle`, `title`, `content`, `view_mode`, `active`, `simple_id`,
`autoscroll`, `autoscroll_offset`, `autoscroll_offset_toolbar` — stored under
`field.formatter.settings.paragraphs_jquery_ui_accordion_formatter` in the entity view display.
Template: `paragraphs-jquery-ui-accordion-formatter.html.twig`; library
`paragraphs_jquery_ui_accordion/accordion`.
