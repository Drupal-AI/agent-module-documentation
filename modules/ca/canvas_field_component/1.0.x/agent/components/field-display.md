<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `field_display` Canvas ComponentSource

Single class: `Drupal\canvas_field_component\Plugin\Canvas\ComponentSource\FieldDisplayComponent`
(`final`, extends `Drupal\canvas\ComponentSource\ComponentSourceBase`, implements
`ContainerFactoryPluginInterface`).

Attribute:
```php
#[ComponentSource(
  id: 'field_display',
  label: new TranslatableMarkup('Field display'),
  supportsImplicitInputs: TRUE, // needs the host entity context at render time
  discovery: FALSE,             // one fixed Component entity, no dynamic discovery
  updater: FALSE,
)]
```
Constant `SOURCE_PLUGIN_ID = 'field_display'`. The install hook creates exactly one Component config
entity `field_display.field_display` (label "Field display") — that is the item a template author
drags in from the Canvas component library.

## What it is (and is not)
- It **is** a Canvas / Experience Builder page-builder *component source* whose rendered output is a Drupal entity field.
- It is **not** a Single Directory Component (no `components/*.component.yml`), **not** a field formatter or widget, **not** `ui_patterns`.
- Intended host: a Canvas **ContentTemplate** (a config entity with target entity type + bundle + view mode). The component reads its context from the ContentTemplate; the actual field values come from the content entity (e.g. a node) being previewed or displayed.

## Stored vs runtime inputs
Persisted in the component tree config (`getExplicitInputDefinitions()`):

| Key | Meaning |
| --- | --- |
| `field_name` | machine name of the field to render |
| `entity_type_id` | host entity type (fallback context) |
| `bundle` | host bundle (fallback context) |
| `view_mode` | ContentTemplate view mode |
| `formatter_id` | chosen field formatter plugin id (empty ⇒ Manage Display fallback) |
| `formatter_settings` | formatter settings (deep-merged with plugin defaults) |
| `formatter_third_party_settings` | third-party settings keyed by provider module |
| `label_display` | `above` \| `inline` \| `hidden` (default `above`) |

Runtime-only, **never persisted** (stripped in `optimizeExplicitInput()`):
`__entity` (resolved `FieldableEntityInterface`) and `__render_array` (the built field render array).

## Lifecycle
1. `getExplicitInput($uuid, $item, $host_entity)` — merges stored inputs with the resolved host entity. Entity comes from `$host_entity` if fieldable, else the component tree root `EntityAdapter`'s entity. Fills `entity_type_id`/`bundle` from the entity when missing (union `+`, so explicit choices win).
2. `hydrateComponent()` — resolves context (stored value `?:` entity-derived `?:` `'default'` view mode), normalizes formatter config, then:
   - `formatter_id !== ''` → `$entity->get($field_name)->view(['type' => $formatter_id, 'settings' => ..., 'label' => $label_display, 'third_party_settings' => ...])`.
   - else → load the Manage Display `EntityViewDisplay`, use `getComponent($field_name)` settings, or bare `->view()`. Back-compat for instances saved before formatter selection existed.
   - Only renders when the entity is fieldable and `hasField($field_name)`. Any `\Throwable` (e.g. formatter plugin uninstalled) → empty render array, page not broken.
3. `renderComponent()` returns `$inputs['__render_array'] ?? []`.
4. `buildComponentInstanceForm()` — the sidebar form: field `select` (required) → formatter `select` → label-display `select` → the formatter's `settingsForm()` in a "Formatter settings" details, plus `hook_field_formatter_third_party_settings_form()` output in "Additional formatter settings". Hidden fields carry `entity_type_id`/`bundle`/`view_mode` from the ContentTemplate. Attaches `canvas_field_component/component_form_refresh`.
5. `clientModelToInput()` / `inputToClientModel()` — convert between the React client model's `resolved` object and stored input. entity_type/bundle derived from the preview entity Canvas always passes (a ContentTemplate is config, never a `$host_entity`).
6. `validateComponentInput()` — only violation is: selected `field_name` no longer exists on the bundle. A field hidden in Manage Display is deliberately still allowed.

## Field options (`buildFieldOptions()`)
- Configurable fields: loaded straight from `field_config` storage (entity_type + bundle, `deleted 0`) so unconfigured-in-this-view-mode fields still appear; fields explicitly set Hidden in Manage Display are excluded via the display's visible-component check.
- Base fields (title/author/created/…): taken from the display's visible components, which naturally drops internal schema fields (langcode, revision_uid, …) and pseudo-fields (links/language).
- Sorted by label with `asort()`.

## Canvas-specific normalization (why the class is large)
- `normalizeFormatterConfiguration()` + `normalizeSubmittedValuesByElement()` — coerce Canvas's all-strings serialization back to Form API types by walking the formatter's real `settingsForm()` element tree (checkbox→bool, checkboxes→selected values, number/weight→int/float). Needed for Smart Date etc.
- `mergeFormatterDefaults()` — deep-merge settings with plugin defaults, replacing list-style arrays wholesale.
- `flattenSelectOptions()` / `afterBuildFlattenOptgroups()` — the Canvas sidebar can't render `<optgroup>`; grouped options are flattened, group label prefixed in parens.
- `rewriteFormatterStatesSelectors()` — remaps formatter `#states` selectors from Field-UI names (`fields[FIELD][settings_edit_form][...]`) to nested Canvas prop names (`canvas_component_props[UUID][...]`).
- `normalizeNestedInputKeys()` / `normalizeInputKeyPath()` — repair bracketed keys (`order][addtocal][weight`) that round-trip through the Canvas form store, so contrib third-party settings save cleanly.
- `enforceTreeOnNestedElements()` — marks nested formatter subform containers `#tree` so deep hierarchies serialize correctly.

## Placing / inspecting it
- UI: Canvas editor → open/create a ContentTemplate → component library → drag **Field display** → pick field → pick formatter → configure settings; live preview updates on select change. Publish the template.
- Config entity: `drush cget canvas.component.field_display.field_display` (source `field_display`, provider `canvas_field_component`).
- Placed instances live in each ContentTemplate's `component_tree`; the source id there is `field_display` with the input keys above.

## Access / safety
Rendering uses core `FieldItemList::view()` → `EntityViewBuilder::viewField()` → a temporary
`EntityViewDisplay` whose `buildMultiple()` applies `$items->access('view')`. So field-level access
control is enforced at render even for fields the author placed that are hidden in Manage Display.
Formatter output is escaped by the formatters themselves. Configuring the component requires Canvas
template-editing (admin/site-builder) access; there are no module routes or permissions.
