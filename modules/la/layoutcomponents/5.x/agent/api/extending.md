<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Components — component API, render element & field plugins

## Form-element API (`src/Api/*`, service `layoutcomponents.apiComponent`)

`Api\Component` (service `layoutcomponents.apiComponent`, ctor `@config.factory`) is the entry
point custom components use to turn a plain Form API element into an LC-styled, live-preview-aware
element. `getComponentElement(array $data, array $element)`:

- If `$data['no_lc']` is TRUE it only wraps the title (via `Api\Color::getLcTitle()`) and returns.
- Otherwise it copies `#title/#description/#default_value/#attributes`, stamps
  `attributes.lc = $data` and `attributes.edit = 'layout-builder-configure-block'`, then dispatches
  on `$data['element']` to a helper:
  - `text` → `Api\Text::plainText()` (CKEditor `text_format` when `input == 'ckeditor'`).
  - `url` → title styling only.
  - `slider` → `Api\Slider::sliderWidget()` (min/max from `#min`/`#max`).
  - `media` → `Api\Media::mediaLibrary()` (allowed bundles from `#target_bundles`).
  - `select` → `Api\Select::normal()` (options from `#options`).
  - `color` → `Api\Color::colorPicker()` (color + opacity sub-elements, LC attributes).
- Returns `array_merge($element, $new_element)`.

Helper classes: `Api\Text`, `Api\Slider`, `Api\Media`, `Api\Select`, `Api\Color` (needs
`ConfigFactory`; reads the `layoutcomponents.colors` palette), `Api\Checkbox`, `Api\General`.
`Api\Component` instantiates the stateless helpers directly (`new Text()` …). This is the
documented "add your own fields" surface for building `lc_*` components.

## Render element & form element

- `Element\LcElement` (`extends Drupal\layout_builder\Element\LayoutBuilder`) — the LC replacement
  for core's `layout_builder` render element, injected by `LcElementInfoManager::alterDefinitions()`.
  Builds the administrative builder (`layout()`, `prepareLayout()`, `buildAddSectionLink()`,
  `buildAdministrativeSection()`, `buildAdministrativeBlock()`, `addTooltip()`).
- `Element\LcColorField` — `@FormElement("color_field_element_box")`, the color+opacity picker box
  used by `Api\Color`.

## Field plugins (`src/Plugin/Field/*`)

A reference field that renders a field of the current (or a chosen) entity inline in a layout:

- **Field type** `layoutcomponents_field_reference` — `FieldType\LcFieldReferenceItem`
  (`extends FieldItemBase`; default widget `layoutcomponents_entity_reference`, default formatter
  `layoutcomponents_entity_formatter`; stores `entity_type`, `entity_id`, `entity_id_context`,
  `entity_field`, `entity_field_label`).
- **Widget** `layoutcomponents_entity_reference` — `FieldWidget\LcFieldReferenceWidget`
  (`extends WidgetBase`; AJAX cascade `getEntityTypes()` → `getEntityContent()` →
  `getEntityFieldsByEntityType()`/`getEntityFieldsByBundle()`; editor picks entity type, entity or
  "current URL context", and the field to render).
- **Formatter** `layoutcomponents_entity_formatter` — `FieldFormatter\LcFieldReferenceFormatter`.
  `viewElements()` resolves the target entity — either from the current request URL
  (`entity_id_context`: parse path → `path_alias.manager` → `Url::fromUri` route params) or from a
  stored `id-bundle` value — loads it, builds the chosen field with the target bundle's `default`
  view-display component options, and renders it to `#markup` via the renderer service.

## Hooks / event recap

`.module` delegates hooks to `LcTheme`/`LcPage`/`LcEntity` through `class_resolver`. Event
`Event\LcPreprocessLayoutEvent` (constant `LC_LAYOUT = 'layoutcomponents_preprocess_layout'`) is
dispatched from `layoutcomponents.theme.inc` carrying the `LcLayoutRender` instance — subscribe to
it to post-process the LC render object before output.
