<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout plugins: Tabs & Accordion

`lb_tabs` implements two core Layout Builder layout plugins (it does not *define* a new
plugin type). Both are subclasses of `LbTabsLayoutBase` (extends
`Drupal\Core\Layout\LayoutDefault`).

| Plugin id | Class | Label | Template | Front-end library |
|---|---|---|---|---|
| `lb_tabs_tabs` | `TabsLayout` | Tabs | `lb-tabs-tabs` | `lb_tabs/tabs` |
| `lb_tabs_accordion` | `AccordionLayout` | Accordion | `lb-tabs-accordion` | `lb_tabs/accordion` |

Both annotations use `category = "Effects"`. They appear in the Layout Builder "Choose a
layout" list for any section (or in Display layout config) once the module is enabled.

## Settings (per layout instance)

Built by `LbTabsLayoutBase::buildConfigurationForm()`, stored via
`submitConfigurationForm()`, defaults from `defaultConfiguration()`.

| Form title | `#type` | Config key | Default | Effect |
|---|---|---|---|---|
| Initially active item | `number` (min 0, step 1) | `initially_active_item` | `NULL` | Zero-based index of the item active on load. Passed to jQuery UI `active`. If empty and `collapsible` is on, none is active initially. |
| Collapsible | `checkbox` | `collapsible` | `FALSE` | Active panel can be closed. Passed to jQuery UI `collapsible`. |
| Use blocks as labels | `checkbox` | `labels_from_blocks` | `FALSE` | See "Where labels come from" below. Description notes: "All links in label region will be removed." |

### Config schema — `config/schema/lb_tabs.schema.yml`
```yaml
layout_plugin.settings.lb_tabs:            # for lb_tabs_tabs
  type: lb_tabs
layout_plugin.settings.lb_tabs_accordion:  # for lb_tabs_accordion
  type: lb_tabs
lb_tabs:
  type: layout_plugin.settings
  mapping:
    initially_active_item: {type: integer}
    collapsible:           {type: boolean}
    labels_from_blocks:    {type: boolean}
```

### Setting a layout programmatically
```php
use Drupal\layout_builder\Section;

$section = new Section('lb_tabs_tabs', [
  'initially_active_item' => 0,
  'collapsible' => TRUE,
  'labels_from_blocks' => FALSE,
]);
// Add regions/components ('content_blocks', and 'label_blocks' when labels_from_blocks).
```

## Regions

`setPluginDefinitionRegions()` builds the region map dynamically:

- `content_blocks` — always present, and the default region.
- `label_blocks` — added **only** for Tabs when `needsLabelBlockRegion()` is `TRUE`
  (Tabs) **and** `labels_from_blocks` is `TRUE`. Accordion never declares this region.

`needsLabelBlockRegion()` returns `TRUE` for `TabsLayout`, `FALSE` for `AccordionLayout`.

## Where labels come from (`LbTabsLayoutBase::build()`)

1. `labels_from_blocks = FALSE` (default): for each content block, the label is that
   block's own configured label — `#configuration['label']` — emitted as
   `['#plain_text' => …]` (falls back to the 1-based index when a block has no label).
2. `labels_from_blocks = TRUE`, Tabs: labels are the actual blocks placed in the
   `label_blocks` region.
3. `labels_from_blocks = TRUE`, Accordion (no label region): every even-indexed
   (0-based) child of `content_blocks` is moved to `label_blocks` and used as a label;
   the remaining children are content.

`build()` then weight-sorts both arrays, pads them to equal cardinality (missing labels
become the 1-based index; missing content becomes an empty element), and attaches
runtime settings.

## Runtime attach & JS

`build()` computes a unique DOM id with `Html::getUniqueId($pluginId)` and attaches:
```php
$build['#attached']['drupalSettings'][$pluginId][$domId] = [
  'active' => is_numeric($initially_active_item) ? (int) $initially_active_item : FALSE,
  'collapsible' => (bool) $collapsible,
];
```
The behaviors iterate those settings and initialize the widget:
- `Drupal.behaviors.lb_tabs` → `$("#" + id, context).tabs(options)`
- `Drupal.behaviors.lb_tabs_accordion` → forces `options.heightStyle = 'content'` then
  `$("#" + id, context).accordion(options)`

## Templates & libraries

Templates (`lb-tabs-tabs.html.twig`, `lb-tabs-accordion.html.twig`) render only when
`content.label_blocks` is non-empty. They detect the Layout Builder editor by checking
`content.content_blocks.layout_builder_add_block is defined`:
- In the editor: attach the CSS-only `lb_tabs/tabs_in_lb` / `lb_tabs/accordion_in_lb`
  library and (tabs) omit the `href` anchors so clicks don't fight the LB UI.
- On the rendered page: attach `lb_tabs/tabs` / `lb_tabs/accordion` (jQuery UI + JS+CSS).

`libraries.yml` declares four libraries; the two front-end ones depend on
`jquery_ui_tabs/tabs` / `jquery_ui_accordion/accordion` plus `core/drupal` and
`core/drupalSettings`.

Labels and content are output with plain `{{ labelBlock }}` / `{{ contentBlock }}` under
Twig autoescaping (no `|raw`); the section id comes from `Html::getUniqueId()` on the
fixed plugin id.
