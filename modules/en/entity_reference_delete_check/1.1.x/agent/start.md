<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Delete Check (entity_reference_delete_check) — agent index

Alters every core **`ContentEntityDeleteForm`** to append a notice listing the entities/fields that
still reference the entity being deleted. **Informational only** — it does not add validation, does
not block or change the deletion, and ships **no config, no permissions, no routes, no plugins**.
Core `^10.3 || ^11`, PHP `^8.1`, license GPL-2.0-or-later. Version 1.1.0.

- **The whole mechanism** (hook_form_alter → usage checker → query → rendering) →
  [mechanism/delete-check.md](mechanism/delete-check.md)
- **URL resolution event + the paragraph_url submodule** →
  [api/url-event.md](api/url-event.md)

## What it actually is (from source)

- `entity_reference_delete_check_form_alter()` in `entity_reference_delete_check.module` — the only
  hook. Acts only when `$form_state->getFormObject()` is a `ContentEntityDeleteForm`; otherwise
  returns. Appends a `#markup` item list; **adds no validate/submit handler**.
- Service `entity_reference_delete_check.entity_reference_usage_checker` →
  `Drupal\entity_reference_delete_check\Service\EntityReferenceUsageChecker` (ctor:
  `entity_type.manager`, `entity_type.bundle.info`, `entity_field.manager`). Method `checkUsages()`
  returns a `Dto\UsageResult` (`entityReferenceFields[]`, `isEmpty()`).
- Event `Event\DeleteCheckEntityUrlEvent` + core subscriber
  `EventSubscriber\DeleteCheckEntityUrlEventSubscriber` resolve a link per referencing entity.
- Submodule **`entity_reference_delete_check_paragraph_url`** (deps: `paragraphs`, this module):
  `EventSubscriber\ParagraphUrlProvider` links paragraph references to their host page.

## Dependencies

- Top-level module: no Drupal module or Composer deps beyond PHP `^8.1` (`require` is php only).
- Submodule requires `paragraphs`. `require-dev` only: `drupal/paragraphs`, `drush/drush`.
