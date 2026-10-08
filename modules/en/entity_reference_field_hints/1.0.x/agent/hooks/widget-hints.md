<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget hints — injection and hint building

All logic lives in two classes. No routes or AJAX are involved; the hint is computed during form
build and rendered as the widget's standard help text.

## Injection: `EntityReferenceFieldHintsHooks`

File: `src/Hook/EntityReferenceFieldHintsHooks.php`. Constructor injects `EntityReferenceHintBuilder`
and `EntityReferenceHintSettings`. Three `#[Hook(...)]` methods:

- `fieldWidgetThirdPartySettingsForm()` — `#[Hook('field_widget_third_party_settings_form')]`.
  Returns nothing when `settings->supportsField($field_definition)` is FALSE. Otherwise returns four
  form elements: `enabled` (checkbox), `show_allowed_bundles` (checkbox), `show_create_permissions`
  (checkbox), `empty_allowed_text` (textfield). The latter three are `#states`-hidden until
  `enabled` is checked. Defaults come from `settings->forWidget($plugin)`.
- `fieldWidgetSettingsSummaryAlter()` — `#[Hook('field_widget_settings_summary_alter')]`. On a
  supported field/widget, appends "Entity reference hints enabled" or "… disabled" to the summary.
- `fieldWidgetCompleteFormAlter()` — `#[Hook('field_widget_complete_form_alter')]`. Returns early
  when `context['default']` is truthy (the default-value widget in field settings) or the widget is
  not a `WidgetInterface`. Reads the field definition from `context['items']->getFieldDefinition()`,
  bails if unsupported or `settings['enabled']` is FALSE, then calls `hintBuilder->build(...)`. If
  lines exist, `attachDescription()` places them.

### `attachDescription()` / `isDescribableElement()`

- `isDescribableElement()` returns TRUE only for `#type` in `checkboxes`, `entity_autocomplete`,
  `radios`, `select`. `attachDescription()` recurses into the complete form array to find the first
  describable element (skipping `#`-prefixed keys).
- On a match it joins the hint lines with a literal `<br>` separator, prepends any existing
  `#description`, wraps the result with `Drupal\Core\Render\Markup::create(...)`, and sets
  `#description_display = 'after'`. Returns after the first attach.

## Hint building: `EntityReferenceHintBuilder::build()`

File: `src/Service/EntityReferenceHintBuilder.php`. Given the field definition and normalized
settings, returns an array of renderable lines:

- **Allowed line** (`show_allowed_bundles`): `getAllowedBundleLabels()` reads
  `handler_settings['target_bundles']` (filtered); if empty, it falls back to *all* bundles of the
  target type via `EntityTypeBundleInfoInterface::getBundleInfo()`. Labels are `Html::decodeEntities()`d,
  `natcasesort()`ed. If any bundles resolve, the line is
  `new TranslatableMarkup('Allowed: @bundles', ['@bundles' => implode(', ', $labels)])`. Otherwise
  it emits `new FormattableMarkup($settings['empty_allowed_text'], ['@target_type' => <plural label>])`,
  where the plural label comes from `getTargetTypeLabel()` (`getDefinition(...)->getPluralLabel()`).
- **Create line** (`show_create_permissions`): `getCreatableBundleLabels()` gets the target type's
  access control handler and keeps only bundles where
  `$access_handler->createAccess($bundle_id, $this->currentUser)` is TRUE, producing
  `new TranslatableMarkup('You can create: @bundles', [...])`. This is scoped to the current user's
  own create access.

## Support check: `EntityReferenceHintSettings::supportsField()`

Returns TRUE only when the field type is `entity_reference` or `entity_reference_revisions` and the
`target_type` setting is one of `media`, `node`, `paragraph`, `taxonomy_term`, `user`.
