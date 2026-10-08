<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_reference_entity_fallback` field formatter

File: `src/Plugin/Field/FieldFormatter/EntityReferenceFallbackFormatter.php`
Class: `Drupal\fallback_media\Plugin\Field\FieldFormatter\EntityReferenceFallbackFormatter extends
Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceEntityFormatter` (core's *Rendered entity*
formatter).

## Plugin definition

`@FieldFormatter(id = "entity_reference_entity_fallback", label = "Rendered entity (with fallback)",
field_types = {"entity_reference"})`. Because it extends the core rendered-entity formatter, it inherits all of
that formatter's settings (view mode, links, etc.).

## Applicability

`isApplicable()` restricts the formatter to entity_reference fields whose storage `target_type` is `media` —
it returns true only when `$field_definition->getFieldStorageDefinition()->getSetting('target_type')` is in
`['media']`. So it appears on the Manage display of media-reference fields only.

## Settings

- `defaultSettings()` adds `fallback_entity => ''` on top of the parent's settings.
- `settingsForm()` calls the parent form, then adds a required `select` element `fallback_entity` whose options
  are the labels of all `fallback_entity` config entities
  (`entityTypeManager->getStorage('fallback_entity')->loadMultiple()`), so the site builder picks which fallback
  definition applies to this display.
- `settingsSummary()` appends a line "Fallback to <label>" using the selected definition's label.

## Rendering (`viewElements()`)

- **Field has values** → `parent::viewElements($items, $langcode)`, i.e. the standard core rendered-entity
  output for the referenced media.
- **Field is empty** (`$items->isEmpty()`) → a single element from `fallbackEntityToView(getSetting('fallback_entity'),
  getSetting('view_mode'))`.

`fallbackEntityToView($fallbackEntityId, $viewMode)`:
1. Loads the `fallback_entity` config entity by id; returns `[]` if it does not exist.
2. Loads the target media entity via `getStorage('media')->load($fallbackEntity->getFallback())`; returns `[]`
   if it does not exist.
3. Renders it with the media view builder: `getViewBuilder($entity->getEntityTypeId())->view($entity, $viewMode,
   $entity->language()->getId())`.

The fallback is thus admin-configured (the definition and its target media are chosen by an administrator through
`/admin/structure/fallback_entity` and the formatter settings), not derived from request input.

## Operate

1. Create one or more `fallback_entity` definitions (see [../config/fallback-entity.md](../config/fallback-entity.md)).
2. On the media-reference field's **Manage display**, choose format *Rendered entity (with fallback)*, pick the
   view mode as usual, and select the fallback definition. Populated fields render normally; empty fields render
   the fallback media in that view mode.
