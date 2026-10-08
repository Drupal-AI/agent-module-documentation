<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity translations helper (entity_translations_helper) — agent index

Two **editor-facing** form enhancements for multilingual content, both driven entirely by
`hook_form_alter()` (no UI, no routes of its own). **(1) Related-translations panel:** on the *edit*
form of a **non-default translation** of a content entity whose bundle has core's *"Hide non
translatable fields on translation forms"* option on (`untranslatable_fields_hide`), it injects a
`entity_translations_helper` details block ("Manage related translations") holding **Add/Edit links**
for the translatable entities referenced by that entity's **non-translatable** `entity_reference` /
`entity_reference_revisions` fields (recursing into `paragraph` children, depth-capped at 5). Each
link opens the referenced entity's translation add/edit form: nodes open in a **new browser tab**,
everything else opens in an **AJAX modal**; on modal submit an AJAX callback closes the dialog and
replaces the link in place. **(2) Creation-language notice:** on the *create* form of a new
`node`/`media`/`taxonomy_term` whose bundle language is **not** alterable via a form element (no
language selector), it injects a `entity_translations_helper_language` details telling the editor
which language they are creating in and offering links to switch to creating it in another language.

The real entry points are the two services called from the form alter, plus a
`hook_entity_extra_field_info()` that registers the `entity_translations_helper_language` pseudo-field
so the notice's placement can be arranged in *Manage form display*.

- Depends on: `drupal:content_translation` (core). Core: `^9 || ^10 || ^11`. Package: `Multilingual`.
- Installed/enabled version **1.1.1** (runtime-verified).
- **No** settings page / `configure` route, **no** permissions, **no** drush, **no** plugin types,
  **no** config schema, **no** routes, **no** libraries of its own (attaches core
  `core/drupal.dialog.ajax`). Provides **two services** and **two hooks**.

## What you'd do → where

- **Understand/trigger the two features, call the services, the AJAX modal convention & selectors** →
  [api/services.md](api/services.md)
- **The hooks implemented and the `entity_translations_helper_language` form pseudo-field** →
  [hooks/hooks.md](hooks/hooks.md)

## Key facts (real machine names)

- Services: `entity_translations_helper` (`Drupal\entity_translations_helper\EntityTranslationsHelper`;
  args `request_stack`, `content_translation.manager`, `entity_type.manager`),
  `entity_translations.language_information`
  (`Drupal\entity_translations_helper\EntityTranslationsLanguageInformation`; args
  `entity_type.manager`, `request_stack`, `current_route_match`, `language_manager`, `renderer`).
- Hooks: `hook_form_alter`, `hook_entity_extra_field_info`.
- Injected form keys: `entity_translations_helper` (details "Manage related translations", weight
  `-999`), `entity_translations_helper_language` (details, creation-language notice).
- Pseudo-field (form context) registered on `node`/`media`/`taxonomy_term` bundles:
  `entity_translations_helper_language` (label "Language helper", weight `-1`).
- AJAX modal convention: query param `entity_translations_helper=ajax` marks a request whose modal
  form should get the in-place submit callback.
- Selector constants (`EntityTranslationsHelper`): base `entity-translations-helper`, modal
  `entity-translations-helper-modal`, wrapper `entity-translations-helper-wrapper`, field-base
  `entity-translations-helper-field-`, entity-base `entity-translations-helper-entity-`.
- Field types scanned for references: `entity_reference`, `entity_reference_revisions`; only
  **non-translatable** fields are candidates; recursion descends into `paragraph` only, max depth 5.
- Trait `AjaxDetectionTrait::isAjaxRequest()` — true when `_wrapper_format` is one of `drupal_ajax`,
  `drupal_modal`, `drupal_dialog`, `drupal_dialog.off_canvas`.
