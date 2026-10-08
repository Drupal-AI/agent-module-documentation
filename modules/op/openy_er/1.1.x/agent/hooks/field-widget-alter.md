<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_field_widget_single_element_form_alter()` — trim the "add new" bundle list

`openy_er.module` implements one hook: `openy_er_field_widget_single_element_form_alter(&$element,
FormStateInterface $form_state, $context)`. It keeps the inline "create a new referenced entity"
bundle selector in sync with a no-dependency handler's allowed bundles.

## What it does (`openy_er.module:15-39`)

1. Reads the field's settings: `$settings = $context['items']->getSettings();`.
2. Bails unless `$settings['handler']` exists and matches `*:*` (i.e. a derived handler like
   `default_no_dep:node`).
3. Splits the handler into `[$type, $entity_type]` and **bails unless `$type == 'default_no_dep'`** —
   so the alter only touches fields using openy_er's handlers.
4. Bails unless `$element['actions']['bundle']` exists (the widget's "bundle to create" select, e.g.
   the entity-reference autocomplete "add new" control).
5. Reduces `$element['actions']['bundle']['#options']` to only the keys present in
   `$settings['handler_settings']['target_bundles_no_dep']`, unsetting every other option.

## Why it exists

Because openy_er stores its allowed bundles under `target_bundles_no_dep` (not the core
`target_bundles` key that the widget natively reads), the widget's "add new" bundle dropdown would
otherwise offer every bundle of the target entity type. This hook re-applies the intended bundle
restriction to that control at render time.

## Notes for agents

- It only fires for fields whose handler string starts with `default_no_dep`; other reference fields
  are untouched.
- It depends on the widget exposing `$element['actions']['bundle']['#options']`; widgets without that
  structure are left alone (the early `isset` guard).
- No access, security, or data-write behaviour here — it is purely a form `#options` filter.
