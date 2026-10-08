<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Transform entity ID to view mode" processor

This module adds exactly one Facets processor. There is no admin settings page
and no module-level config object — everything is configured **per facet**,
inside that facet's own config, through the Facets UI (or config/PHP).

## The plugin

| Property | Value |
| --- | --- |
| Plugin id | `translate_view_mode_entity` |
| Annotation | `@FacetsProcessor` |
| Label | Transform entity ID to view mode |
| Stage / weight | `build` = `6` (runs after the built-in `translate_entity` label processor at weight 5) |
| Class | `Drupal\facets_view_mode_processor\Plugin\facets\processor\TranslateEntityViewModeProcessor` |
| Parent | `Drupal\facets\Plugin\facets\processor\TranslateEntityProcessor` |
| Setting | `view_mode` (single, required) |

## Requirement: the facet must be an entity reference

`supportsFacet()` is inherited from the parent, so the processor only appears on
facets whose data definition is (or contains a property that is) an
`entity_reference`. At build time `getEntityType()` walks the facet's data
definition property definitions and picks the first one that is a
`DataReferenceDefinitionInterface` with data type `entity_reference`; the
referenced entity type id is what gets rendered. If no such property exists it
throws `Drupal\facets\Exception\InvalidProcessorException`
("Field doesn't have an entity definition, so this processor doesn't work.").

Typical setup: create a facet on an entity-reference field (e.g. a taxonomy-term
reference), so the facet's raw values are the referenced entity ids.

## Enable it — UI

1. Go to the facet's edit form (*Configuration → Search and metadata → Facets*, edit a facet).
2. Under **Processors**, tick **Transform entity ID to view mode**.
3. In that processor's settings, choose the **View mode** (the select lists the view modes available for the referenced entity type, from `entity_display.repository`).
4. Save. Leave the built-in "Transform entity ID to label" processor unchecked — this one supersedes it visually.

## Enable it — exported facet config

The setting lives on the `facets.facet.<id>` config entity, not on this module:

```yaml
processor_configs:
  translate_view_mode_entity:
    processor_id: translate_view_mode_entity
    weights:
      build: 6
    settings:
      view_mode: teaser
```

## Enable it — PHP / Drush

```php
$facet = \Drupal::entityTypeManager()->getStorage('facets_facet')->load('my_facet');
$facet->addProcessor([
  'processor_id' => 'translate_view_mode_entity',
  'weights' => ['build' => 6],
  'settings' => ['view_mode' => 'teaser'],
]);
$facet->save();
```

`Facet::addProcessor()` stores exactly `processor_id` / `weights` / `settings`
keyed by the processor id. Use `$facet->removeProcessor('translate_view_mode_entity')`
to turn it back off.

## What happens at runtime (`build()`)

For every render of the facet, `TranslateEntityViewModeProcessor::build()`:

1. Reads `view_mode` from its configuration and resolves the referenced entity type via `getEntityType($facet)`.
2. Collects the raw value (the referenced **entity id**) of each result, then `loadMultiple()`s all of them from that entity type's storage in one query.
3. For each result: if the entity no longer exists it drops the result (`unset`); otherwise it renders the entity with the entity type's view builder — `$view_builder->view($entity, $config['view_mode'], $langcode)` in the current interface language — and replaces the result's display value (`setDisplayValue()`) with that render array.

So the facet item's "label" becomes the full rendered view-mode markup of the
referenced entity. The entity ids come from the search index (the facet
results), not from request input.

## Caveat from the README

The rendered markup ends up inside a facet widget element (often a checkbox
label), which only accepts a limited subset of HTML. If a view mode produces
block-level or otherwise invalid markup for that context it may render oddly.
The recommended fix is to override the template of the chosen view mode so you
fully control each facet item's markup.

## Schema

The module ships **no** `config/schema/*.yml`. The `view_mode` value is stored
inside the facet's `processor_configs` and covered by Facets' generic processor
settings schema, not by this module.
