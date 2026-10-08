# How it works (mechanism)

Implemented in `src/Hook/FieldWidgetHooks.php` (service, autowired) with two hooks; a
`.module` file provides `#[LegacyHook]` shims. No config UI, plugins, or Drush.

## 1. The settings checkbox — `hook_field_widget_third_party_settings_form()`

`thirdPartySettingsForm(WidgetInterface $plugin, FieldDefinitionInterface $field_definition)`:
- Reads the field storage cardinality. **Returns an empty array** (no checkbox) when cardinality
  is `CARDINALITY_UNLIMITED` (-1) **or** `1`.
- Otherwise returns an `add_more` `#type => checkbox` titled **"Show add more button"**, whose
  default is the current third-party setting `field_widget_add_more.add_more`.

So the option is offered only on **fixed cardinality > 1** fields.

## 2. The widget rewrite — `hook_field_widget_complete_form_alter()`

`completeFormAlter(&$field_widget_complete_form, $form_state, $context)`:
- Skips programmed forms. Reads the widget's `field_widget_add_more.add_more` third-party
  setting; **returns early if not truthy**.
- Uses `WidgetBase::getWidgetState()` to read `items_count`; if it is 0, sets it to 1 (start with
  one row). `$max = min(items_count, cardinality)`.
- Iterates the rendered deltas: unsets any delta `>= $max` (so only the used rows show), and adds
  a per-row **Remove** submit (`WidgetBase::deleteSubmit` / `deleteAjax`) to each remaining row.
- Wraps the widget in a uniquely-id'd `<div>` and appends an **"Add another item"** submit
  (`#name` `<id>_add_more`, `WidgetBase::addMoreSubmit`) with an AJAX callback
  `FieldWidgetHooks::addMoreAjaxCallback`. Its `#access` is TRUE only while
  `$max < cardinality` (or unlimited), so the button disappears at the cap.

## 3. The AJAX callback — `addMoreAjaxCallback()`

Returns an `AjaxResponse` that replaces the widget container with the re-rendered widget
(one more row), wraps the new delta in an `ajax-new-content` div, and issues a `FocusFirstCommand`
so the first field of the new row gets focus.

## Consequences an agent should know

- The whole feature is driven by the single boolean third-party setting on the form-display
  component; there is no global toggle.
- It never changes field **storage** or cardinality — it only alters the **edit widget**, showing
  rows incrementally up to the existing cap.
- It works with **any widget type** because it alters the *complete* widget form, not a specific
  widget plugin.
- No effect on cardinality-1 or unlimited fields (unlimited already has core's own Add-more).
