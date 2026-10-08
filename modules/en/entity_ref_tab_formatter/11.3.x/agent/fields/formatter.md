<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity reference tab formatter" formatter

## Install & enable

```bash
composer require drupal/entity_ref_tab_formatter
drush en entity_ref_tab_formatter -y
drush cr
```

No hard dependencies (info.yml declares none). The **Views block** body option needs core **Views**
enabled; the **Rendered entity** option and Paragraphs integration need no extra module.

## Enable it on a field

Plugin id **`entity_reference_tab_formatter`**, label *"Entity reference tab formatter"*, applies to
`field_types = { "entity_reference", "entity_reference_revisions" }`. Class
`EntityReferenceTabFormatter` extends core `FormatterBase` (implements
`ContainerFactoryPluginInterface`).

UI path: *Structure → (bundle) → Manage display* → set the reference field's format to
**Entity reference tab formatter** → click the gear to configure. Best on a multi-value field so
there is more than one tab/panel.

## Settings (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `tab_title` | `''` | Field on the referenced bundle used for the tab/accordion header. Options are the referenced bundles' `FieldConfig` fields plus a synthetic `title`. Falls back to `'title'`, then to the entity `label()`, then to *"Item N"*. Required in the form. |
| `tab_body` | `''` | What fills the panel body. A field machine name, or the sentinel `__rendered_entity` ("Rendered entity (full view)") or `__views_block` ("Views block"). Required in the form. |
| `style` | `'tab'` | `tab` or `accordion` (schema `Choice`). |
| `rendered_view_mode` | `'default'` | View mode used when `tab_body === '__rendered_entity'`. Options from `entity_display.repository` for the target bundle. |
| `accordion_mode` | `'single'` | `single` (one panel open) or `multiple` (schema `Choice`). |
| `accordion_header_color` | `'#f5f5f5'` | Header background color (`#type => color`). Re-validated at render against `/^#[0-9A-Fa-f]{3,6}$/`; anything else is dropped before it reaches the template's `--entity-ref-accordion-header-color` CSS var. |
| `accordion_header_full_width` | `FALSE` | Adds modifier class `entity-ref-tab-formatter-accordion--full`. |
| `accordion_icon_alignment` | `'right'` | `left` or `right` (schema `Choice`) — summary icon side. |
| `views_block` | `''` | `viewid:displayid` selection, populated only from View displays whose `display_plugin === 'block'`. |
| `views_block_arguments` | `''` | Optional comma-separated contextual filter args, parsed by `parseViewsArguments()` (trim + drop empties). |

The accordion_* and views_* fields are shown/hidden with `#states` keyed off `style` and `tab_body`.
`settingsSummary()` prints the chosen title field, the body mode, and the accordion options.

Config schema: `field.formatter.settings.entity_reference_tab_formatter` in
`config/schema/entity_ref_tab_formatter.schema.yml`, with `Choice` constraints on `style`,
`accordion_mode`, and `accordion_icon_alignment`.

### Example view-display config

```yaml
# core.entity_view_display.paragraph.tabs.default (fragment)
content:
  field_items:
    type: entity_reference_tab_formatter
    label: hidden
    settings:
      tab_title: field_heading
      tab_body: field_body
      style: accordion
      rendered_view_mode: default
      accordion_mode: single
      accordion_header_color: '#f5f5f5'
      accordion_header_full_width: false
      accordion_icon_alignment: right
      views_block: ''
      views_block_arguments: ''
```

## How rendering works (`viewElements()`)

For each field item it resolves the entity (`$item->entity`, else load by `target_id`), then:

1. **Title** — reads `tab_title` field's first value via `getString()`; if that field is `title` it
   uses `$entity->label()`; empty → *"Item N"*.
2. **Body** — three branches:
   - `__rendered_entity`: `entityTypeManager->getViewBuilder(type)->view($entity, $rendered_view_mode)`.
   - `__views_block`: `buildViewsBlockRenderable()` loads the View, `setDisplay()`, checks
     `$view->access($display_id)`, applies parsed arguments, and returns `buildRenderable()`; an
     empty result yields a *"No content returned…"* message.
   - a field name: `$entity->get($body_field)->view($this->viewMode, $langcode)`, with a fallback to
     `#type => processed_text` (using the item's `format`) or `#plain_text` when the field render is
     empty.
3. Each tab is keyed `{entity-id}-{delta}` and pushed to `$tabs`.

Then it builds `#theme => 'entity_ref_tab_formatter'` (tabs) or `entity_ref_accordion_formatter`
(accordion, with `#accordion_mode`, `#header_color`, `#header_full_width`, `#icon_alignment`) and
attaches the matching library. No referenced items → *"No referenced items available."*.

`viewValue()` exists but is unused dead code from the field-formatter scaffold
(`nl2br(Html::escape($item->value))`).

## Templates & JS

- **Tabs** (`entity-ref-tab-formatter.html.twig`): a `role="tablist"` of `<button role="tab">`
  triggers and `role="tabpanel"` panels; ids come from `fieldkey|clean_id`; non-first panels get
  `hidden`. `js/tab_formatter.js` (`Drupal.behaviors.entityRefTabFormatter`, via `core/once`) wires
  click + arrow/Home/End keyboard navigation and toggles `aria-selected`/`hidden`.
- **Accordion** (`entity-ref-accordion-formatter.html.twig`): native `<details>`/`<summary>`; the
  first item is `open`; header color set via inline `--entity-ref-accordion-header-color`.
  `js/accordion_formatter.js` (`Drupal.behaviors.entityRefAccordionFormatter`) closes sibling
  panels on `toggle` when mode is `single`.
- Both `{{ fieldname.title }}` and `{{ fieldname.body }}` are output through Twig autoescape; body
  render arrays are rendered by the theme layer, not concatenated as raw strings.

## Notes / caveats

- The formatter builds the tab list itself rather than extending `EntityReferenceFormatterBase`, so
  the standard reference-formatter niceties (e.g. `getEntitiesToView()`) are not used — it loads and
  iterates the items directly.
- `views_block` options only include View displays whose plugin is `block`; if none exist the field
  is disabled with a hint to enable Views / add a block display.
- The color, arguments, view-mode and view/block selections are **admin-only** formatter settings
  (set on Manage display), not request input.
