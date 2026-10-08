<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Develop an Overview Builder plugin

The module adds the `overview_builder` plugin type (annotation `@OverviewBuilder`, manager service `plugin.manager.overview_builder`). See the `overview_builder_example` submodule for a working reference.

## Base classes
- `OverviewBuilderBase` — implements `OverviewBuilderInterface`; general base.
- `ViewsOverviewBuilderBase` — back an overview with a View (throws `MissingViewIdException` if no view id).
- `CustomOverviewBuilderBase` — build a fully custom listing.
- `CustomOverviewBuilderFiltersFormBase` — provide exposed filters.

A plugin implements `build()` returning a render array; the module provides the `overview_builder` theme hook with variables `wrapper_attributes`, `attributes`, `filters`, `items`, `pager`, `empty` (template `overview-builder.html.twig`).

## Wiring an overview into an entity
- Via **Pluginreference**: add a field that references the OverviewBuilder plugin to your entity/bundle.
- Via **Paragraphs** (optional dependency): enabling Paragraphs installs an "overview" paragraph type with the `field_overview` plugin-reference field (`config/optional/*`). Add that paragraph to an entity to place an overview.

## AJAX overviews
Set `ajax` truthy in the plugin definition to allow refresh via route `overview_builder.ajax.overview` (`/ajax/overview-builder/{plugin_id}`, POST). The `AjaxController::overview()`:
1. 404s if the plugin id is unknown or its `ajax` flag is off.
2. Reads `path` from POST, requires `pathValidator->isValid($path)`.
3. Re-creates/registers the request for that path (so `<current>` tokens resolve), builds the plugin, and returns an `AjaxResponse` `ReplaceCommand` targeting `.js-overview-builder-overview[data-overview-id=<plugin_id>]`.

The endpoint is read-only rendering; it does not persist anything.
