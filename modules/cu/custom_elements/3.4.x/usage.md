<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Elements renders Drupal entities and fields as custom-element markup — `<node-article-teaser title="…"><p slot="body">…</p></node-article-teaser>` — or as an equivalent JSON tree, so a front end built from web components or a JS framework consumes structure instead of parsing Drupal's themed HTML. It is the rendering core of Lupus Decoupled Drupal.

---

The module centres on one value object, `CustomElement` (a tag, an optional tag-prefix, a flat map of attributes, and weighted named *slots* that hold either markup or nested `CustomElement`s). The `custom_elements.generator` service turns a content entity plus a view mode into that tree, choosing among four build paths: a **Custom Elements Display** config entity (`entity_ce_display`, one per entity-type.bundle.view_mode) whose components map each field to a **CustomElementsFieldFormatter** plugin (`auto`, `plain_text`, `raw`, `link`, `image`, `file`, `entity_ce_render`, `entity_bundle_type`, `timestamp`, `path`, `flattened`, `canvas`, or `field:<core-formatter>` wrapping any core formatter); legacy **auto-processing** via tagged `custom_elements_processor` services (the 2.x behaviour); **Layout Builder** (emitting `<drupal-layout>`); or a **Canvas** content template. Two output layers consume the tree: `template_preprocess_custom_element` + the `custom_element` theme hook render markup (attributes go through Drupal's `Attribute` object, so they are HTML-escaped; slots render as `#markup`), with a `web_component` style (default) and a `vue-3` style (`<template #slot>` named slots, array attributes bound as `:prop`); and `CustomElementNormalizer` serialises to JSON in either an `explicit` format (`{element, props:{…}, slots:{…}}`, the default) or a `legacy`/implicit format (props and slots merged at the root). Settings live at `/admin/config/system/custom-elements` (`administer site configuration`): `markup_style`, `json_format`, `default_render_variant`. Field-level view access is checked when building display components and by the media/paragraph processors; entity-level rendering is enabled either per view-mode ("Force custom elements rendering", any view mode named `custom_elements*` auto-enables) for progressive decoupling, or wholesale via `lupus_ce_renderer` for full decoupling. A second plugin type, **CustomElementsPreviewProvider** (`markup`, `json`, `nuxt`), renders in-Drupal previews. Submodules: `custom_elements_ui` (a "Manage custom element" Field-UI tab at `…/ce-display`, gated by dynamic per-entity-type `administer <type> custom element display` permissions), `custom_elements_thunder` (ships CE-display config for Thunder paragraph/media types), and `custom_elements_extra_formatters` (a `ce_tablefield` formatter). Version **3.4.1** on core `^10 || ^11`, PHP 8.1+ (Canvas needs 11.2+/PHP 8.3+). The contract to establish before committing is the element/attribute names — they become an API, and renaming one breaks the front end.

---

- Render an entity view mode as a custom element for a web-component front end.
- Feed a JS-framework (Vue/React) front end structured components instead of HTML.
- Serialize content to a JSON component tree (`explicit` or `legacy` format).
- Progressively decouple: keep Drupal rendering but let browser web components take over specific view modes.
- Fully decouple by pairing with Lupus Custom Elements Renderer / Lupus Decoupled Drupal.
- Map each field to a custom-element attribute or slot via a Custom Elements Display.
- Wrap any core field formatter for custom-element output with the `field:<id>` formatter.
- Output a plain-text/string field as an attribute or slot (`plain_text`, with truncation options).
- Render a referenced entity nested inside the parent element (`entity_ce_render`).
- Emit an entity reference's bundle type id without rendering the target (`entity_bundle_type`).
- Output a link field as a resolved `href` plus an `external` flag (`link`).
- Emit image/file references with an image style (`image`, `file`).
- Render Thunder paragraphs/media as custom elements via the Thunder submodule config.
- Render Layout Builder layouts into `<drupal-layout>` custom elements.
- Render a Canvas content template into a `components` slot.
- Switch slot syntax to Vue 3 named slots for a Vue front end.
- Configure the JSON serialization format site-wide (explicit vs legacy).
- Choose a default render variant (markup vs a preview provider).
- Preview custom-element output in the admin UI via a Nuxt front end (`nuxt` preview provider).
- Add a bespoke field-to-element mapping with a custom `CustomElementsFieldFormatter` plugin.
- Customize rendering of a field/entity type with a tagged `custom_elements_processor` service.
- Alter a generated element via `hook_custom_element_entity_alter()` / `hook_custom_element_entity_defaults_alter()`.
- Configure per-entity-type who may edit custom-element displays via dynamic permissions.
- Keep Drupal's cache metadata (tags/contexts) attached through the whole element tree.
- Reuse one front-end component library across several Drupal front ends.
- Support a Thunder-style architecture where Drupal owns *what* renders and the front end owns *how*.
