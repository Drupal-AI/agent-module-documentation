# Formdazzle! — agent index

Enriches **Twig theme suggestions** for forms, form elements, and labels — each suffixed with
the form ID and element name — so a front-end dev can template one field on one form. No
config, no output, no routes, no services beyond the hook class, no Drush. Depends on nothing.

- **The suggestion patterns it adds, worked examples, special form-ID handling, the Twig-debug
  comment behaviour, and how to create a matching template** →
  [theming/suggestions.md](theming/suggestions.md)

Key facts:
- Runs on `hook_form_alter` (forced to run **last**) and adds a `#pre_render`
  (`Dazzler::preRenderForm`) so suggestions are computed after every other alter.
- Pattern: `<theme-hook>__<form-id-suggestion>__<element-name>`, e.g.
  `input--textfield--webform-contact--first-name`.
- Labels handled in `hook_preprocess_form_element`. No new files needed to enable — just
  install; then add templates in your theme.
