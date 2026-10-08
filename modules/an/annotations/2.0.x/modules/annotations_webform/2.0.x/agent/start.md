<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Webform (annotations_webform) — agent index

Webform + WebformSubmission target plugins and submission-form overlay injection. Depends on `annotations`, `annotations_overlay`, `webform`.

## Provides

- **Target plugins** (`src/Plugin/AnnotationsTarget/`):
  - `WebformTarget` — `#[AnnotationsTarget(id: 'webform')]`, `hasFields()` FALSE; each webform is a bundle (scope key `webform__{id}`).
  - `WebformSubmissionTarget` — `#[AnnotationsTarget(id: 'webform_submission')]`; shadows the generic derivative and enumerates the webform's input elements (`getElementsInitializedFlattenedAndHasValue()`, `isInput()` only) as fields (scope key `webform_submission__{id}`).
- **Decorator** `annotations_webform.field_label_resolver` (`WebformFieldLabelResolver`) `decorates: annotations.field_label_resolver` — returns element `#title` for `webform_submission` field lookups.
- **Hooks** `annotations_webform.hooks` (`AnnotationsWebformHooks::formAlter`) — injects overlay triggers into `webform_submission` forms by wrapping `$form['elements'][$key]` in a positioning container (`#prefix`/`#suffix`), because the base overlay's form_alter skips elements nested under `elements`.

## Notes for agents

- Trigger injection only reaches top-level elements (`isset($form['elements'][$key])`); elements nested in containers/fieldsets/wizard pages are skipped by design.
- The wrapper markup echoes only the element machine name, the admin-authored `#title`, and the shared glyph icon (`AnnotationsOverlayTriggerBuilder`) — no end-user submission data.
