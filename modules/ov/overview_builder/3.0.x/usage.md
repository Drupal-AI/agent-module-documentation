<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an `overview_builder` plugin type so developers can attach an overview (a View or a custom listing) to entities, referenced through a field so content managers still control the surrounding page.

The benefit is that an overview page can also be a real entity (e.g. a node): its path, metatags, header/footer text and layout stay editable by content managers, while the listing itself is a reusable plugin. Overviews are referenced via the [Pluginreference](https://www.drupal.org/project/pluginreference) module. When [Paragraphs](https://www.drupal.org/project/paragraphs) is enabled, the module ships optional config creating an "overview" paragraph type with an `field_overview` plugin-reference field, so overviews drop into a paragraphs setup; otherwise you add your own field referencing the OverviewBuilder plugin. The module defines base classes (`OverviewBuilderBase`, `ViewsOverviewBuilderBase`, `CustomOverviewBuilderBase`), a plugin manager (`plugin.manager.overview_builder`), an `@OverviewBuilder` annotation, a filters form base, and an `overview-builder.html.twig` theme hook.

For AJAX-enabled overviews it exposes a single route `overview_builder.ajax.overview` at `/ajax/overview-builder/{plugin_id}` (POST, permission `access content`). The controller only rebuilds a defined overview plugin whose definition has `ajax` enabled; it reads the current `path` from POST, validates it with the path validator, re-matches it through the router to make `<current>`-style URLs resolve, and returns an AjaxResponse that replaces the overview markup — it is a read-only rendering endpoint, not a mutation. A companion `overview_builder_example` submodule demonstrates writing plugins.
---
A developer plugin type to embed reusable views/custom overviews into entities.
---
- Define a custom `@OverviewBuilder` plugin for a listing.
- Wrap a View as an overview with `ViewsOverviewBuilderBase`.
- Build a fully custom overview with `CustomOverviewBuilderBase`.
- Reference an overview from an entity via a pluginreference field.
- Use the shipped "overview" paragraph type when Paragraphs is on.
- Let content managers set the path/metatags of an overview page.
- Add exposed filters to an overview via the filters form base.
- Enable AJAX refresh of an overview without full page reload.
- Theme overview output via `overview-builder.html.twig`.
- Provide a pager on a custom overview listing.
- Study `overview_builder_example` to scaffold a new plugin.
- Inject `plugin.manager.overview_builder` to load overviews in code.
- Render an overview inside a node body via a paragraph.
- Make `<current>` path tokens resolve inside AJAX overviews.
- Restrict which overviews are AJAX-refreshable via plugin `ajax` flag.
- Reuse one overview plugin across multiple entity types.
- Return custom empty-state markup when an overview has no items.
- Add wrapper/attributes to overview markup via theme variables.
- Build a landing page whose body is a filtered content overview.
- Combine multiple overviews on one entity via multiple fields.