<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `component_blocks` derived block

`Drupal\component_blocks\Plugin\Block\ComponentBlock` (annotation id `component_blocks`, category
"Component blocks") with deriver `Drupal\component_blocks\Plugin\Deriver\ComponentBlockBlockDeriver`.
One block plugin per UI Patterns component, rendered with values pulled from the host entity.

## Derivatives (deriver)

`ComponentBlockBlockDeriver::getDerivativeDefinitions()` loops every UI Patterns definition
(`plugin.manager.ui_patterns`) crossed with every **content** entity type
(`entityClassImplements(ContentEntityInterface::class)`), yielding:

- **Derivative id**: `<entity_type_id>:<pattern_id>` → full plugin id `component_blocks:<entity_type_id>:<pattern_id>`
  (e.g. `component_blocks:node:test_component`).
- `admin_label`: `"<component label> with fields from <entity type label>"`.
- `_block_ui_hidden: TRUE` — hidden from the standard block-layout UI; surfaced in Layout Builder.
- `ui_pattern_id`: the pattern machine name (read later by the plugin).
- `context_definitions.entity`: an `EntityContextDefinition` for that entity type — the block needs a
  content entity in context (Layout Builder supplies the current entity).

Adding/renaming a pattern requires a cache rebuild (`drush cr`) for new derivatives to appear.

## Runtime context

The block reads its entity from `$this->getContextValue('entity')`. In Layout Builder the mapping is
`context_mapping.entity` (e.g. `@…context:node`). `build()` calls `$entity->getEntityTypeId()` and the
entity view builder, so the block only renders where that context is populated.

## Configuration (per block; no settings page)

Set in `ComponentBlock::blockForm()` / persisted by `blockSubmit()`. Stored config keys (see schema
`block.settings.component_blocks:*:*`):

| Key | Type | Meaning |
| --- | --- | --- |
| `variant` | string | Selected pattern variant machine name (select shown only if the pattern declares `variants`). |
| `variables` | sequence of `component_blocks.context_variable` | One entry per pattern field, keyed by field name. |
| `variables.<field>.source` | string | Either `__fixed` (constant `ComponentBlock::FIXED`) or an entity field machine name. |
| `variables.<field>.value` | string | The fixed/token string, used only when `source === __fixed`. |
| `variables.<field>.type` | string | Field formatter plugin id, used only when `source` is a field. |
| `variables.<field>.settings` | `field.formatter.settings.[type]` | Formatter settings for that formatter. |
| `settings` | sequence of string | Pattern settings, present only when `ui_patterns_settings` is installed. |

Form behaviour:
- For each pattern field with `ui` not `false`: a **Source** `select` whose options are the sample
  entity's field labels plus `__fixed` → "Fixed input". An AJAX callback (`updateElementValue`) rebuilds
  the row. `formatterSettingsProcessCallback()` then adds, per selection, either a **Fixed value**
  `textfield` (source `__fixed`) or a **Formatter** `select` (`getApplicablePluginOptions()`, filtered by
  `FormatterInterface::isApplicable()`) plus that formatter's settings form.
- Pattern fields declared with `ui: false` are forced to `source: __fixed` + the pattern-defined
  `default`, rendered as hidden `#type: value` (no editor input; `setConfiguration()` also strips their
  stored `value` to avoid duplicates).
- If `ui_patterns_settings` is enabled, `SettingsFormBuilder::layoutForm()` injects the pattern's
  settings under `settings` (relabelled "Pattern settings").

## Build pipeline (`ComponentBlock::build()`)

For each configured variable:
- **`source === __fixed`**: if the value is non-scalar (an array default) it is passed through as-is.
  Otherwise the string is run through the **token** service:
  `$this->token->replace($value, [<entityTypeId> => $entity], [], $metadata)`. If replacement changed
  the string it is wrapped in `Markup::create(...)` (the code comments this as "token replacement
  sanitizes"); an `EntityMalformedException` yields `''`.
- **`source` is a field**: the entity view builder renders that field through the chosen formatter —
  `$view_builder->viewField($entity->get($source), ['type','settings'] + ['label' => 'hidden'])`. Empty
  output contributes only cache metadata; otherwise it is wrapped as `['#theme' => 'field__component_block'] + $output`.

The result is assembled into a UI Patterns render element:

```php
$build = [
  '#type' => 'pattern',
  '#id' => $this->pluginDefinition['ui_pattern_id'],
  '#fields' => $context,               // keyed by pattern field name
  '#context' => ['type' => 'entity', 'entity' => $entity],
];
// plus '#variant' and '#settings' when configured
```

Libraries declared on the pattern (`$definition->getLibrariesNames()`) are attached. Cacheability from
the entity, token replacement and field rendering is collected in a `BubbleableMetadata` and applied to
`$build`. The `#type => pattern` element (owned by `ui_patterns`) renders the component's Twig template
with `#fields` as variables.

## PHP: place/configure programmatically

```php
// e.g. inside a Layout Builder section component config, or a test:
$values = [
  'variant' => 'default',
  'variables' => [
    'subtitle' => ['source' => '__fixed', 'value' => '[node:title]'],
    'body'     => ['source' => 'body', 'type' => 'text_default', 'settings' => []],
  ],
  'settings' => ['modifier' => 'Example modifier'],
  'context_mapping' => ['entity' => '@my.context:node'],
];
```

Plugin id is `component_blocks:<entity_type_id>:<pattern_id>`.
