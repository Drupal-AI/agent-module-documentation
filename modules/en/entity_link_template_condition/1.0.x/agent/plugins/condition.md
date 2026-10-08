<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugin: Entity Link Template

File: `src/Plugin/Condition/EntityLinkTemplateCondition.php`
Class: `Drupal\entity_link_template_condition\Plugin\Condition\EntityLinkTemplateCondition`
Extends core `ConditionPluginBase`, implements `ContainerFactoryPluginInterface`.

## Identity

- Declared with the PHP attribute `#[Condition(id: self::PLUGIN_ID, label: new TranslatableMarkup('Entity Link Template'))]`.
- `public const PLUGIN_ID = 'entity_link_template';` — the plugin **id** is `entity_link_template`
  (note: the *module* machine name is `entity_link_template_condition`).
- A standard `condition` plugin, so it appears wherever core collects conditions — chiefly **block
  visibility** in Block layout.

## Install / enable

- `drush en entity_link_template_condition -y` (pulls in `entity_route_context`). Then place/edit a
  block and open its **Visibility → Entity Link Template** section. No admin config page.

## Dependencies injected (`create()` / constructor)

- `entity_type.manager` (`EntityTypeManagerInterface`) — enumerates entity types and their link
  templates for the form options.
- `current_route_match` (`RouteMatchInterface`) — the request being evaluated.
- `entity_route_context.route_helper` (`EntityRouteContextRouteHelperInterface`, from the
  `entity_route_context` module) — maps a route match to `[entityTypeId, linkTemplateKey]`.

## Settings

`defaultConfiguration()` returns two keys (plus the base condition keys `negate`, `context_mapping`):

- `link_templates_any`: `string[]` of bare link-template keys (e.g. `['canonical', 'edit-form']`) —
  match that key on **any** entity type.
- `link_templates`: `string[]` of `"$entityTypeId:$linkTemplateKey"` (e.g. `['node:edit-form']`) —
  match an **exact** entity type + key.

Config schema (`config/schema/entity_link_template_condition.schema.yml`): type
`condition.plugin.entity_link_template` → `condition.plugin`, with `link_templates` and
`link_templates_any` each a `sequence` of `string`. Stored on the host config (e.g. a block's
`visibility.entity_link_template`); the module defines no config object of its own.

## Form (`buildConfigurationForm()` / `submitConfigurationForm()`)

- Builds options from `getLinkTemplates()` (all distinct link-template keys across every entity type,
  via `EntityTypeInterface::getLinkTemplates()`) and `getLinkTemplatesByEntityType()` (keyed
  `entityTypeId:key`, labelled "*EntityLabel: key*").
- Renders two `#type => checkboxes` groups: `link_templates_any` ("…link template for any entity
  type") and `link_templates_entity_type` ("…matches an exact entity type"). Both option lists are
  `asort()`-ed. Labels use `@`-placeholder translation (auto-escaped).
- On submit, both are stored as `array_values(array_filter(...))` (drops unchecked/empty), into
  `configuration['link_templates_any']` and `configuration['link_templates']` respectively.

## `evaluate()`

1. If both `link_templates_any` and `link_templates` are empty → return `FALSE`.
2. `[$entityTypeId, $linkTemplateKey] = $this->routeHelper->getLinkTemplateByRouteMatch($this->routeMatch);`
   (the helper returns `null` when the route is not an entity link template).
3. If `$entityTypeId` is truthy: return `TRUE` when `$linkTemplateKey` is in `link_templates_any`
   (strict `in_array`), or when `"$entityTypeId:$linkTemplateKey"` is in `link_templates`.
4. Otherwise `FALSE`.

This is **visibility** logic (does this block show?), not an access decision — it does not restrict
entity or route access.

## `summary()`

Returns `t('Link templates: @link_templates', ['@link_templates' => $this->configuration['link_templates']])`.
The value is the raw `link_templates` array; the human-readable summary is minimal.

## Helper methods

- `getLinkTemplates(): string[]` — union of `array_keys($entityType->getLinkTemplates())` across all
  entity-type definitions, `array_unique`-d.
- `getLinkTemplatesByEntityType(): array` — per entity type, keys → translated `"Label: key"`
  labels; empty entity types filtered out.

## Verify

Kernel test `tests/src/Kernel/EntityLinkTemplateConditionTest.php`: empty config → `evaluate()`
FALSE; with `link_templates_any => ['canonical']` but off-route → FALSE; after setting the current
request to route `entity.entity_test.canonical` → TRUE.
