<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The entity_reference_modal field widget

`Drupal\entity_reference_modal\Plugin\Field\FieldWidget\EntityReferenceModalWidget`
(attribute `#[FieldWidget(id: 'entity_reference_modal', label: 'Autocomplete (add new with Modal)', field_types: ['entity_reference'])]`)
extends core `EntityReferenceAutocompleteWidget`. Select it on any `entity_reference` field under
**Manage form display**.

## Settings (`defaultSettings()` + `settingsForm()`)

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `add_new_button_title` | textfield | `+` | Label of the Add-new dropbutton link; rendered with `Markup::create()`, so **HTML is allowed** (admin-controlled). |
| `modal_form_mode` | select | `default` | Form mode used to build the create-new modal form (options from `entity_display.repository:getFormModeOptions`). |
| `modal_width` | textfield | `80%` | Passed into `data-dialog-options` width. |
| `modal_title` | textfield | `Add new` | Modal/dialog title. |
| `duplicate` | checkbox | FALSE | If off, on save the module reuses an existing target with the same label instead of creating a new one. |
| `search` | checkbox | TRUE | Adds the 🔎 search link + Bootstrap-table dialog. |
| `view_and_display` | select | '' | Optional Entity-Reference view display (`view_id:display_id`) used to build search columns/results; only from `Views::getApplicableViews('entity_reference_display')` matching the target type. |
| `bootstrap` | checkbox | FALSE | Loads Bootstrap 5 from CDN for themes that are not Bootstrap 5. |
| `tagify` | checkbox | FALSE | **Disabled in the UI** (`#attributes: ['disabled' => 'disabled']`), described as "in progress"; `js/entity-reference-tagify.js` is effectively dead code (no wired autocomplete endpoint). |

## What `formElement()` builds

- Calls the parent to get the normal autocomplete `target_id` textfield, then attaches
  `entity_reference_modal/entity_reference_modal`.
- Computes the input selector and calls `prepareFormState()` to seed `$form_state`
  `['entity_reference_modal', $selector]` widget state with the currently referenced entities.
- Determines target bundles from the field's `handler_settings['target_bundles']`; if empty and the field
  uses a views handler, it introspects the view's `type`/`vid` filters to derive bundles.
- Renders a `#type => dropbutton` in `target_id['#description']` with:
  - **one Add-new link per bundle** — but only if `AccessControlHandler::createAccess($bundle)` passes for the
    current user (bundles the user cannot create are skipped). Each link is a `use-ajax` button
    (`data-dialog-type=modal`, `btn btn-success`) to route `entity_reference_modal.entity_form` with query
    `selector`, `mode`, `duplicate`, `delta`, `field`.
  - **a search link** (when `search` is on) to route `entity_reference_modal.search`, carrying the
    HMAC `selection_settings_key`; column defs + `search_key` are pushed to
    `drupalSettings.entity_reference_search[<field>]`.
- Optionally attaches `…/bootstrap` and/or `…/tagify` libraries.

## Notes

- The dropbutton create links respect **create** access per bundle — a user who may *reference* a bundle but
  not *create* it will simply not see that bundle's Add button (and the modal route enforces the same check).
- `view_and_display` in `settingsForm()` builds its option list via `Views::getApplicableViews()` /
  `entity_type.manager` — the widget's settings form requires the `views` module even though `.info.yml`
  declares no dependency on it.
