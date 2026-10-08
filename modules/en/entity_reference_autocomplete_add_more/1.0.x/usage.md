A developer module that registers a Form API render element (`entity_reference_autocomplete_add_more`) giving any custom form an entity-reference autocomplete input with AJAX "Add another item" and "Remove" buttons.

---

Drupal core's `entity_reference_autocomplete` widget only works on entity forms because it needs a field storage attached to an entity. This module fills the gap for plain custom forms: it defines a single reusable render element, implemented by `Drupal\entity_reference_autocomplete_add_more\Element\EntityReferenceAutocompleteAddMore`, that you drop into any form array with `'#type' => 'entity_reference_autocomplete_add_more'`. Each row is a standard core `entity_autocomplete` input (so it reuses core's selection handlers, `#target_type` and `#selection_settings`), and the element wraps the rows in an AJAX container with an "Add another item" button plus a per-row "Remove" button. Adding and removing rows rebuilds the form and re-renders just the element's wrapper via `ajaxCallback()`, so the user never loses a page. Submitted values arrive under the element key as `['items'][$i]['target_id']`. The module has no admin UI, no configuration, no routes, no permissions and no dependencies beyond core — it is intended purely for developers assembling custom forms.

---

- Collect several node references on a custom settings or config form that has no field storage.
- Let an editor pick a variable-length list of related content in a bespoke admin form.
- Build a "featured items" selection form where the number of picks is not fixed.
- Reference multiple users (e.g. assign several reviewers or team members) from a custom action form.
- Add a multi-value taxonomy-term picker to a form that is not an entity edit form.
- Gather a list of media entities to attach in a custom bulk-processing form.
- Provide an "add more" entity selector inside a multistep form wizard step.
- Pre-populate an edit form with existing references via `#default_value` and let the user grow or trim the list.
- Restrict selectable entities to specific bundles using `#selection_settings['target_bundles']`.
- Tune autocomplete match behavior per field with `#selection_settings['match_limit']`.
- Sort autocomplete suggestions by passing a `sort` key inside `#selection_settings`.
- Build a form that references different entity types by setting `#target_type` per element (node, user, taxonomy_term, media, etc.).
- Require at least one reference by setting `#required` on the element.
- Replace hand-rolled "unlimited cardinality" AJAX add/remove logic in a custom form with a single ready-made element.
- Create a lightweight tagging or curation UI without defining a field on any entity.
- Let admins configure a list of entity references stored later in `config` or `state`.
- Reference several entities from a Batch or Form-API-driven import/mapping screen.
- Add repeatable entity pickers to a custom block configuration form.
- Build a relationship-editing form (e.g. link one entity to many others) outside the entity edit workflow.
- Prototype multi-reference input quickly during module development before deciding on a real field.
- Provide an entity-reference "add more" control inside a plugin configuration form.
- Read submitted references in `submitForm()` by iterating `$form_state->getValue('field_name')['items']`.
- Offer editors an autocomplete picker where each pick has its own input box rather than a comma-separated tags field.
- Add or remove reference rows entirely client-side (via AJAX) so no full page reload interrupts editing.
