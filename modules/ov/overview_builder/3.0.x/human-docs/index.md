# Overview Builder — manual setup guide

**Overview Builder** (`overview_builder`) is a **developer** module. It adds a
new plugin type — `overview_builder` — that lets you attach an "overview" (a
Views listing or a fully custom listing) to an entity, referenced through a
field. The clever part is that the page showing the overview can itself be a real
entity, such as a node: its path, metatags, header and footer text, and layout
all stay editable by a content manager, while the listing itself lives in
reusable code.

Overviews are wired up through the
[Pluginreference](https://www.drupal.org/project/pluginreference) module, which
this module depends on: a field references your overview plugin, and the plugin
decides what to render. If the
[Paragraphs](https://www.drupal.org/project/paragraphs) module is enabled,
Overview Builder ships optional configuration that creates a ready‑made
"overview" paragraph type (with a plugin‑reference field), so your overviews drop
straight into a Paragraphs setup. If you would rather not use Paragraphs, you add
your own field that references the OverviewBuilder plugin.

For developers, the module provides the base classes (`OverviewBuilderBase`,
`ViewsOverviewBuilderBase`, `CustomOverviewBuilderBase`), a plugin manager
(`plugin.manager.overview_builder`), an `@OverviewBuilder` annotation, a filters
form base, and an `overview-builder.html.twig` theme hook. Overviews can also be
refreshed over AJAX. Because writing overviews is a coding task, the bundled
`overview_builder_example` submodule is the best starting point.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   Pluginreference dependency, and (optionally) enable Paragraphs and the example
   submodule.

There is **no configuration page** for this module. It is developer
infrastructure: you build overview plugins in code and reference them from a
field. The AJAX refresh route it exposes (`/ajax/overview-builder/{plugin_id}`)
is read‑only — it only re‑renders a defined, AJAX‑enabled overview plugin — and
is not something you configure through the UI.

## How to use it

1. Write an overview plugin in a custom module, extending
   `ViewsOverviewBuilderBase` (to wrap a View) or `CustomOverviewBuilderBase` (for
   a fully custom listing), annotated with `@OverviewBuilder`. Copy the
   `overview_builder_example` submodule as a template.
2. Add a way to reference it from content:
   - With **Paragraphs** enabled, use the shipped "overview" paragraph type,
     which already has an overview field, or
   - Add your own field to an entity that references the OverviewBuilder plugin
     via Pluginreference.
3. Because the host is a real entity (e.g. a node), let content managers set its
   path, metatags, and surrounding text as usual — the overview renders inside it.
