<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Widget Action — the inline "AI Suggested References" button

Plugin `AiAutoReferenceFormSuggestion` (id **`ai_auto_reference_form_suggestion`**),
`src/Plugin/FieldWidgetAction/AiAutoReferenceFormSuggestion.php`. It extends
`field_widget_actions`' `FieldWidgetFormActionBase` — the module **defines no plugin type of its own**;
it implements the type provided by the optional `field_widget_actions` module. If that module is not
installed, this plugin is simply never discovered and only the batch-button route (see
[../api/generation.md](../api/generation.md)) is available.

## Attribute / targeting

`#[FieldWidgetAction(...)]`: label "AI Suggested References", category "AI Auto-reference",
`field_types: [entity_reference]`, `widget_types:`
`entity_reference_autocomplete_tags`, `entity_reference_autocomplete`,
`tagify_entity_reference_autocomplete_widget`, `tagify_select_widget`, `options_select`,
`options_buttons`. (Plain Entity Reference "Add another" is not supported.) Configured per field on the
content type's **Manage form display** page as a Field Widget Action; the plugin also declares
`ai_auto_reference/widget-button` in `getLibraries()`.

## Availability & access

- `isAvailable()` returns TRUE only when the current user has
  **`access ai auto-reference suggestion tools`** and a `provider` is configured. When it returns
  FALSE, `field_widget_actions` never renders the button (confirmed by
  `AiAutoReferenceFwaPermissionTest`).
- `buildModalForm()` re-checks the same permission and bails to an unmodified form if it is missing; it
  also only proceeds for form ids starting `node_` or ending `_form`.

## Modal build — `buildModalForm(array $form, $form_state, ?ContentEntityInterface $entity)`

1. Resolves entity + `target_element_field_name` from the FWA context data.
2. Reads the field's `ai_auto_reference` third-party settings (`view_mode`, `prompt`) from
   `{entity_type}.{bundle}.default` form display; shows a warning if not configured.
3. For a **new/unsaved** entity there is no rendered view, so it builds `override_content` from the
   entity's own text fields (`string`, `string_long`, `text`, `text_long`, `text_with_summary`),
   skipping the target field.
4. Calls `aiReferenceGenerator->getAiSuggestions(entity, field, view_mode, prompt, override_content)`.
   Result is **cached one-shot** in the FWA TempStore entry (`field_widget_actions_form_collection`
   keyed by `tempstore_id`) so that clicking Insert (which rebuilds the form) does not trigger a second
   API call. (Kernel test `AiAutoReferenceSuggestionCacheTest` covers this.)
5. Loads the suggested entities (`storage->loadMultiple`) and builds options labelled
   `"{label} ({id})"`:
   - **High** relevance → `checkboxes` (all checked). If the field cardinality is 1, it becomes
     `radios` with a "- None -" option and medium suggestions are folded into the same group.
   - **Medium** relevance (multi-value only) → a second `checkboxes` group, none checked.
   - No suggestions → a warning status message.

Suggestion ids come from the generator's **access-filtered** allowed-value set, so the modal cannot
surface an entity the current user may not reference; labels are Form-API option labels (escaped).

## Insert — `submitModalFormFillFields(array $form, $form_state, AjaxResponse $response)`

Collects selected ids (radio scalar for cardinality 1, else filtered checkbox arrays merging high +
medium), then emits an AJAX command matching the widget type to fill the real field client-side:

| Widget type | Command | Selector notes |
|---|---|---|
| `entity_reference_autocomplete_tags`, `tagify_entity_reference_autocomplete_widget` | `FillSimpleFieldCommand` | comma-joined `"label (id)"` into `[name="{field}[target_id]"]` |
| `entity_reference_autocomplete` | `FillSimpleFieldCommand` | `[name="{field}[0][target_id]"]` (card. 1) or `[name="{field}[target_id]"]` |
| `options_select`, `tagify_select_widget` | `FillSelectCommand` | `[name="{field}[widget]"]` (card. 1) or `[name="{field}[widget][]"]` |
| `options_buttons` | `FillCheckboxesOrRadiosCommand` | only if that command class exists (pending field_widget_actions #3578204) |

`buildEntity()` is overridden to fall back to the saved entity when the parent throws (e.g.
`options_select` with `#limit_validation_errors` leaving raw scalar values) — safe because the modal
only needs type/bundle/field-definition context, not unsaved scalar values.
