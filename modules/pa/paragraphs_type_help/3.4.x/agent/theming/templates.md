<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming

## Theme hook

`paragraphs_type_help` (`hook_theme`, render element `elements`). Default template
`templates/paragraphs-type-help.html.twig`. `template_preprocess_paragraphs_type_help()` sets:
- `view_mode` — the help entity view mode.
- `paragraphs_type_help` — the help entity.
- `paragraph_bundle` — host Paragraph bundle id (or `''`).
- `paragraph_form_mode` / `paragraph_view_mode` — the host paragraph's display mode when known.
- `content` — child render elements.

It also attaches the `paragraphs_type_help/host_edit_form` CSS library
(`css/paragraphs_type_help.host_edit_form.css`) for styling the help block on the edit form.

## Theme suggestions

`paragraphs_type_help_theme_suggestions_paragraphs_type_help()` provides (in order):
- `paragraphs_type_help__<view_mode>`
- `paragraphs_type_help__<paragraph_bundle>`
- `paragraphs_type_help__<paragraph_bundle>__form__<form_mode>` (on forms)
- `paragraphs_type_help__<paragraph_bundle>__view__<view_mode>` (on views)
- `paragraphs_type_help__<help_id>`
- `paragraphs_type_help__<help_id>__<view_mode>`

Override per bundle or per help item by creating the matching `.html.twig` in your theme
(dots in mode names become underscores).
