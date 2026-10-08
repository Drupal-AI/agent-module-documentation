# Extend Layout Paragraphs — events & API

As of 2.x all custom hooks were removed; extension happens through **events** plus native
Drupal hooks. See `layout_paragraphs.api.php`.

## Events (subscribe with an EventSubscriber)

### Restrict allowed components — `LayoutParagraphsAllowedTypesEvent`
`Drupal\layout_paragraphs\Event\LayoutParagraphsAllowedTypesEvent`
(event name const `EVENT_NAME = 'layout_paragraphs_allowed_types'`).
Fired when building the "Choose a component" dialog. Use it to limit which paragraph types
may be added in a specific region/section.

```php
public static function getSubscribedEvents(): array {
  return [LayoutParagraphsAllowedTypesEvent::EVENT_NAME => 'restrict'];
}
public function restrict(LayoutParagraphsAllowedTypesEvent $event) {
  $types  = $event->getTypes();        // array of type definitions (each has 'is_section' bool)
  $region = $event->getRegion();       // target region name
  $parent = $event->getParentUuid();   // parent component uuid (NULL at root)
  $layout = $event->getLayout();       // LayoutParagraphsLayout
  $event->setTypes(array_filter($types, fn($t) => $t['id'] !== 'banned_type'));
}
```
The module's own `LayoutParagraphsAllowedTypesSubscriber` already uses this to enforce
`require_layouts` (root must be sections) and `nesting_depth` (deep levels can't be sections).

### Preset new-component type/defaults — `LayoutParagraphsComponentDefaultsEvent`
`EVENT_NAME = 'layout_paragraphs_component_defaults'`. Change the paragraph type or default
field values applied to a newly created component: `getParagraphTypeId()` /
`setParagraphTypeId()`, `getDefaultValues()` / `setDefaultValues()`.

### Control builder refresh — `LayoutParagraphsUpdateLayoutEvent`
`EVENT_NAME = 'layout_paragraphs_update_layout'`. After an operation, compare
`getOriginalLayout()` vs `getUpdatedLayout()` and set the public `$needsRefresh = TRUE` when a
partial AJAX update is insufficient and the whole builder must re-render.

## The `LayoutParagraphsLayout` domain object

`Drupal\layout_paragraphs\LayoutParagraphsLayout` wraps a paragraphs reference field and its
settings. Construct with the field item list; key methods:

- Read: `getComponents()`, `getRootComponents()`, `getComponentByUuid($uuid)`,
  `getComponent($paragraph)`, `getLayoutSection($paragraph)`, `getEntities()`, `isEmpty()`,
  `getSettings()` / `getSetting($key)`, `getFieldName()`, `getEntity()`.
- Mutate: `setComponent()`, `appendComponent()`, `insertIntoRegion($parentUuid, $region, $p)`,
  `insertBeforeComponent()`, `insertAfterComponent()`, `reorderComponents($ordered)`,
  `duplicateComponent($sourceUuid, $targetSectionUuid = NULL)`, `deleteComponent($uuid, $recursive)`.
- Third-party settings: implements `ThirdPartySettingsInterface`.

Persist in-progress edits with the tempstore service `layout_paragraphs.tempstore_repository`
(`LayoutParagraphsLayoutTempstoreRepository`): `get()`, `getWithStorageKey($key)`, `set()`,
`delete()`, `getStorageKey()`.

## Other services

- `layout_paragraphs.renderer` (`LayoutParagraphsRendererService`) — `renderLayoutSection()`,
  `buildLayoutSection()`; builds the Layout Discovery render array for a section.
- `layout_paragraphs.builder_access` (`LayoutParagraphsBuilderAccess`) — the
  `_layout_paragraphs_builder_access` route access check.
- `layout_paragraphs.param_converter.tempstore` — resolves `{layout_paragraphs_layout}` route
  params from the tempstore.

## Native hooks (see `layout_paragraphs.api.php`)

- `hook_form_layout_paragraphs_component_form_alter(&$form, &$form_state)` — alter the
  component add/edit form.
- `hook_entity_view_alter()` — modify a component's build; detect via
  `$build['#layout_paragraphs_component']`, and tweak UI via
  `$build['drupalSettings']['lpBuilder']['uiElements']`.
