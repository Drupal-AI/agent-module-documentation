<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin & deriver (one block per preset)

## Block — `DynamicFacetCascadeBlock`

`src/Plugin/Block/DynamicFacetCascadeBlock.php`, extends `BlockBase`, implements `ContainerFactoryPluginInterface`.

- `@Block` id `dynamic_facet_cascade_block`, admin_label *"Dynamic Facet Cascade"*, category *"Search"*, `deriver = DynamicFacetCascadeBlockDeriver`.
- DI: `form_builder`, `entity_type.manager`.
- `build()`: takes the **derivative id = the preset machine name** (`getDerivativeId()`); if empty, renders a "No preset configured" message; otherwise returns `formBuilder->getForm('\Drupal\dynamic_facet_cascade\Form\DynamicFacetCascadeForm', $preset_id)` — i.e. the block just renders the frontend cascade form for its preset (see forms/cascade-form.md).
- Cache metadata: `getCacheContexts()` adds `url.query_args` (dropdowns pre-populate from the URL, so output varies by query string). `getCacheTags()` adds `taxonomy_term_list` plus the preset entity's own cache tags (invalidate when terms change or the preset is edited).

## Deriver — `DynamicFacetCascadeBlockDeriver`

`src/Plugin/Deriver/DynamicFacetCascadeBlockDeriver.php`, extends `DeriverBase`, implements `ContainerDeriverInterface` (DI `entity_type.manager`).

- `getDerivativeDefinitions()`: loads all `dynamic_facet_cascade_preset` entities and creates one derivative per preset, keyed by the preset id, with `admin_label` set to the preset's label. Result: Block Layout shows a distinct, labelled entry per preset (e.g. "Cars Search") instead of one generic block.

## Placing it

After saving a preset, place its block (Structure -> Block Layout) in a region above the target search view, and set visibility to the search page. The block ID = `dynamic_facet_cascade_block:{preset_id}`.
