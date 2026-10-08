<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter: Rendered entity with access bypass fallback

Source: `src/Plugin/Field/FieldFormatter/EntityReferenceEntityViewAccessBypassFallback.php`.

## Plugin

- Class `EntityReferenceEntityViewAccessBypassFallback extends` core `EntityReferenceEntityFormatter` (`\Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceEntityFormatter`).
- Declared via `#[FieldFormatter(...)]`:
  - `id: entity_reference_entity_view_access_bypass_fallback`
  - `label`: "Rendered entity with access bypass fallback"
  - `description`: "Display the referenced entities rendered by entity_view(). In case you cannot access the entity, fallback to a specific view mode."
  - `field_types: ['entity_reference']` — targets any entity_reference field.

## Settings

- `defaultSettings()` adds `view_mode_fallback => 'default'` on top of `parent::defaultSettings()` (which provides `view_mode` and `link`).
- `settingsForm()` calls the parent form, then adds a required `view_mode_fallback` select whose options come from `entityDisplayRepository->getViewModeOptions($this->getFieldSetting('target_type'))`. Description: "Fallback to this view mode in case user cannot access to this entity."
- `settingsSummary()` appends "Fallback rendered as @mode" to the parent summary.
- No config schema file ships with the module; settings are stored in the field's view-display config like any formatter's.

## Mechanism (how it differs from core)

- `getEntitiesToView()` (override): for each loaded item it loads `$item->entity`, resolves the translation via `entityRepository->getTranslationFromContext()`, runs `$access = $this->checkAccess($entity)`, and records `$item->_accessCacheability`. Unlike core — whose `EntityReferenceFormatterBase::getEntitiesToView()` only appends the entity `if ($access->isAllowed())` — this version appends **every** loaded entity as `['entity' => $entity, 'access' => $access->isAllowed()]`. So targets the user cannot view are kept in the list rather than dropped.
- `viewElements()` (override): iterates that list and, for each entry, calls
  `$view_builder->view($entity, $access ? $view_mode : $view_mode_fallback, $entity->language()->getId())`.
  Accessible entities render in the configured `view_mode`; inaccessible ones render in `view_mode_fallback`. It also copies core's recursion guard (`static $depth`, aborts and logs to the `entity` channel above depth 20) and the RDFa `resource` attribute handling.
- `checkAccess()` is inherited unchanged from core (entity-level `view` access). The bypass is not a change to the access check itself — it is that the result no longer gates rendering; instead it only selects which view mode is used.

## Operating it

- Enable the module, then on Manage display of an entity reference field select "Rendered entity with access bypass fallback" and set both `view_mode` (used when the viewer has access) and the required `view_mode_fallback` (used when the viewer does not).
- The fallback view mode is what limited and anonymous users are shown for referenced entities they cannot access, so populate it only with fields intended for those viewers. Individual field access is still enforced by the core entity view pipeline; the entity-level view-access result is what this formatter deliberately does not use to hide the entity.
