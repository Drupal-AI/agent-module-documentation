<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: source, mapping and sync handlers

The module defines three plugin types; each converter's config selects which handlers run. All are
standard annotation-based plugins discovered under `src/Plugin/<Type>/`.

## maps_sync_source_handler

- Manager `plugin.manager.maps_sync_source_handler` (`SourceHandlerPluginManager`, dir
  `Plugin/SourceHandler`, interface `SourceHandlerInterface`, annotation `@SourceHandler` with
  `id`, `title`, `description`).
- Role: fetch the raw items to import for a converter (calls `MapsApi` and returns counts + data).
- Shipped plugins (`src/Plugin/SourceHandler/`): **MapsObject** (objects), **Media** (media —
  builds the target `uri` from `const:<medias_path>/+filename`), **Library** (library trees);
  shared logic in `AttributesTrait` and `SourceHandlerPluginBase`.

## maps_sync_mapping_handler

- Manager `plugin.manager.maps_sync_mapping_handler` (`MappingHandlerPluginManager`, dir
  `Plugin/MappingHandler`, interface `MappingHandlerInterface`, annotation `@MappingHandler`).
- Role: convert one MaPS source value into one Drupal field/property value (a `mapping` row's
  `handler`). Base class `MappingHandlerPluginBase`.
- Shipped plugins (`src/Plugin/MappingHandler/`): **DefaultHandler**, **IntegerHandler**,
  **FloatHandler**, **DateHandler**, **HtmlHandler**, **LinkHandler**, **MediaHandler**,
  **EntityReferenceHandler**, **EntityReferenceRevisionHandler**, **CriteriaAttributeHandler**
  (writes `contextualized_attribute` values). `MappingRequiredException` is thrown when a `required`
  mapping produces no value (behavior governed by the row's `requiredBehavior`).

## maps_sync_handler

- Manager `plugin.manager.maps_sync_handler` (`MapsSyncHandlerManager`, dir `Plugin/MapsSyncHandler`,
  interface `MapsSyncHandlerInterface`, annotation `@MapsSyncHandler` with `id`, `label`).
- Role: the top-level import handler for a converter (`Converter::handler_id`) — orchestrates
  loading the Drupal target entity, applying every mapping handler, resolving media, and setting
  publication status. Base class `MapsSyncHandlerBase`.
- Shipped plugins (`src/Plugin/MapsSyncHandler/`): **DefaultHandler** (generic entities) and
  **MediaHandler** (media entities — maps MaPS media types to Drupal media types/fields, manages
  the file URI/scheme and optional image-style flushing).

## Extending

Add a class under the matching `Plugin/<Type>/` directory of your module with the correct
annotation and interface; the parent-`default_plugin_manager` managers pick it up automatically.
Derivatives for local tasks/actions are provided by `MapsSyncLocalTaskDeriver` and
`MapsSyncEntityActionsDeriver` (`src/Plugin/Derivative/`).
