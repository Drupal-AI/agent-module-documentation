<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overview Builder (overview_builder) — agent index

**Developer module adding an `overview_builder` plugin type to attach reusable views/custom overviews to entities.**

- **Version:** 3.0.x · **Package:** Overview
- **Core:** ^9 || ^10 || ^11 · **Depends on:** pluginreference (optional integration: paragraphs)
- **Plugin type:** `@OverviewBuilder` annotation; manager `plugin.manager.overview_builder`; base classes `OverviewBuilderBase`, `ViewsOverviewBuilderBase`, `CustomOverviewBuilderBase`; filters form base; theme `overview_builder` (`overview-builder.html.twig`).
- **Route:** `overview_builder.ajax.overview` → `/ajax/overview-builder/{plugin_id}` (POST, permission `access content`) — rebuilds an ajax-enabled overview plugin.
- **Optional config:** "overview" paragraph type + `field_overview` when Paragraphs is enabled. Example: `overview_builder_example` submodule.

**Security:** the one route is gated by `access content` (effectively public) but is **read-only** — it only re-renders a defined overview plugin whose definition has `ajax` enabled, after path-validating the POSTed `path`; no mutation or arbitrary rendering. No security findings.

See [plugins/develop.md](plugins/develop.md).