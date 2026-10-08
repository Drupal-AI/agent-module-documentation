<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types & component plugins (value generation)

## The four plugin types

Managers in `entity_template.services.yml`, all `parent: default_plugin_manager`, discovered
under `src/Plugin/EntityTemplate/`:

- **Builder** — `TemplateBuilderManager`, `@EntityTemplateBuilder`, dir `.../Builder`.
  `BuilderBase` (abstract) + `ConfigTemplateBuilder`. A builder resolves available blueprints
  and executes the selected one. `ConfigurableDefaultBlueprintTrait` supports a default
  blueprint for default field values.
- **Template** — `TemplateManager`, `@EntityTemplate`, dir `.../Template`. `Template`
  (abstract) → `BlueprintTemplate`; interfaces `ConditionalTemplateInterface`,
  `SubTemplateInterface`. A template creates the target entity and applies its components.
- **Component** — `TemplateComponentManager`, `@EntityTemplateComponent`, dir `.../Component`
  (alter hook `entity_template_component`). Components set individual fields.
- **Blueprint provider** — `TemplateBlueprintProviderManager`,
  `@EntityTemplateBlueprintProvider`, dir `.../BlueprintProvider`. `BuilderDefault` and
  `ConfigTemplateBlueprint` (id `blueprint_config`) source blueprints (from config).

## How a template applies to an entity

`Template::execute()` (src/Plugin/EntityTemplate/Template/Template.php:264) calls
`createEntity()` for the target type/bundle, then for each component applies context mapping
(`context.handler`) and calls `$component->apply($entity, $result)`. The result entity is
handed to the build controller's entity form (see [../api/build-flow.md](../api/build-flow.md)).

## Component plugins & value generation

`FieldComponentBase` (extends `ComponentBase`) binds a component to a specific
entity-type/bundle/field via the `EntityFieldStorageDeriver` (so component ids look like
`field.widget_input:node.field_x`). Key components:

- **`field.widget_input`** (`FieldWidgetInputComponent`, `@EntityTemplateComponent`
  id `field.widget_input`). Collects a value with the field's normal **widget**
  (`buildConfigurationForm`/`submitConfigurationForm` use `WidgetPluginManager`) and stores it
  in `configuration['value']`. `apply()` sets `$entity->{field} = getValue()` — a **static**
  value, no interpolation. Swappable with `field.data_select` via `SwappableComponentInterface`.
- **`StringFieldWidgetInputComponent`** — attached to `string`, `string_long`, `text`,
  `text_long` fields via `entity_template_field_info_alter()` in `entity_template.module`.
  Its `apply()` (src/.../StringFieldWidgetInputComponent.php:124) interpolates each stored
  value against the template's contexts. **Two engines**, chosen by `rendersTwig()`:
  - `text_long`, `text_with_summary`, `string_long` → **Twig**: `renderTwig()` runs
    `twig->renderInline((string) $template, $variables)` inside a `RenderContext`, with the
    context *values* (entities, scalars) as Twig variables.
  - other string types (e.g. `string`) → **placeholder replacement**:
    `placeholderResolver->replacePlaceHolders($value, $data, …)` using the context *typed
    data*. Short strings stay on placeholders; prose uses Twig for conditionals.
- **`FieldDataSelectComponent` / `DateTimeFieldDataSelectComponent`** (`field.data_select`) —
  set a field from a typed-data selector/expression (`DataSelectComponentTrait`), the
  "Value Select" counterpart to direct input.
- **`InlineTemplate`** (id `field.inline_template`, `field_types = entity_reference`,
  deriver `EntityFieldStorageDeriver`) — a sub-template: `execute()` builds a *referenced*
  entity from its own nested components and assigns it to the reference field (single or
  multi-value). Implements `SubTemplateInterface` so nested components inherit contexts.

## Placeholder & Twig internals

- **`PlaceholderResolver`** (src/PlaceholderResolver.php) subclasses typed_data's resolver and
  is swapped in by `EntityTemplateServiceProvider`. Its only change from upstream: apply
  filters through `DataFetcher::applyFiltersToValue()` so filters that declare
  `usesWrappedValue()` (e.g. `format_field`, `option_label`) get the TypedData object.
  Resolved placeholder values are wrapped in `HtmlEscapedText` unless already `MarkupInterface`.
- **`DataFilterTwigExtension`** (`entity_template.twig.data_filters`, tagged `twig.extension`)
  registers every typed_data DataFilter plugin as a Twig filter of the same name (skipping
  `ENGINE_FILTERS` that Twig/Drupal already define). `applyDataFilter()` converts an entity to
  its typed data and runs the filter via the data fetcher. These filters are marked
  `is_safe => ['html']` because they return rendered field/date/URL markup.
- **`DataFetcher`** (src/DataFetcher.php) and `DataFilterTwigExtension` are the bridge that
  makes a filter name mean the same thing in a placeholder and in Twig.

## Extending

Add a component by creating an `@EntityTemplateComponent` plugin (or, for a field-bound
component, register a class via `hook_field_info_alter()`'s `entity_template_component` key as
the module does for string fields). Add a builder / blueprint provider by implementing the
corresponding annotation + interface. The UI submodule attaches add/configure PluginForms via
`entity_template_ui_entity_template_*_alter()`.
