<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity reference modal (entity_reference_modal) — agent index

A single **field widget** for `entity_reference` fields that extends core's autocomplete widget with:
1. an **"Add new" button** that opens the target entity's create form in a **modal** and injects the saved entity back into the field, and
2. an optional **Bootstrap-table search dialog** for picking existing referenceable entities.

There are no permissions, no admin config form, and no drush commands — everything is configured on a
field's **Manage form display** by choosing the widget "Autocomplete (add new with Modal)".

## What you'd do → where

- **Enable / configure the widget** → [agent/fields/widget.md](fields/widget.md) — the
  `EntityReferenceModalWidget` plugin, its settings, and how the dropbutton links are built.
- **Understand the modal create/save flow** → [agent/forms/modal-create.md](forms/modal-create.md) —
  the `entity_reference_modal.entity_form` route, its access check, and the AJAX submit in `.module`.
- **Understand the search endpoint** → [agent/api/search.md](api/search.md) — the
  `entity_reference_modal.search` JSON route and `fieldReference()` controller.

## Key facts (real names)

- **Widget plugin:** `entity_reference_modal` — `Drupal\entity_reference_modal\Plugin\Field\FieldWidget\EntityReferenceModalWidget`,
  extends `EntityReferenceAutocompleteWidget`; label "Autocomplete (add new with Modal)"; `field_types: [entity_reference]`.
- **Widget settings** (schema `field.widget.settings.entity_reference_modal`): `add_new_button_title` (default `+`, HTML allowed),
  `modal_form_mode` (default `default`), `modal_width` (`80%`), `modal_title`, `duplicate` (bool), `search` (bool, default TRUE),
  `bootstrap` (bool), `view_and_display` (string), `tagify` (bool — checkbox is disabled/experimental).
- **Routes:**
  - `entity_reference_modal.entity_form` → `/entity-reference-modal/form/{entity_type}/{bundle}` →
    `EntityReferenceModalController::build`; access `EntityReferenceModalController::access` (requires a
    `drupal_modal`/`_drupal_ajax` request, then entity `createAccess()`).
  - `entity_reference_modal.search` → `/entity-reference-modal/search/{target_type}/{selection_handler}/{selection_settings_key}` →
    `EntityReferenceModalController::fieldReference`; `_access: 'TRUE'`, GET, `_format: json`.
- **Controller:** `Drupal\entity_reference_modal\Controller\EntityReferenceModalController`
  (services: `page_cache_kill_switch`, `request_stack`, `form_builder`, `plugin.manager.entity_reference_selection`).
- **Hooks (procedural, `.module`):** `hook_form_alter` adds `status_messages` + AJAX submit `entity_reference_modal_submit`
  to the modal form; `entity_reference_modal_submit()` saves the entity (dedup by label unless `duplicate`) and returns
  an `InvokeCommand('injectEntity', …)`. `entity_reference_modal_children_element()` re-runs value callbacks/validators
  on child field elements during that submit.
- **Hooks (OOP):** `Drupal\entity_reference_modal\Hook\EntityReferenceModalHook::help` (`#[Hook('help')]`) renders README.md.
- **Selection settings key:** `Crypt::hmacBase64(serialize(settings).target.handler, hash_salt)`, stored in the
  `entity_autocomplete` key-value collection; passed to the search route as `{selection_settings_key}`.
- **JS/libraries:** `entity_reference_modal/entity_reference_modal` (injectEntity), `…/search-bootstrapTable`,
  `…/bootstrap`, `…/bootstrapTable`, `…/tagify`. Bootstrap 5.3.6, Bootstrap-table 1.22.6, Tagify 4.32.2 load from jsDelivr CDN.
- **Real dependencies:** core `field` (parent widget) and `views` (`Drupal\views\Views` is used in the widget settings form
  and controller) — note the `.info.yml` declares **no** dependencies.
- **Core requirement:** `^10 || ^11 || ^12`. License GPL-2.0-or-later.
