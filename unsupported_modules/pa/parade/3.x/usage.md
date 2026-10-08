<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Parade is a page-building toolkit built on the Paragraphs module for assembling flexible landing pages from reusable components with live in-editor previews.

---

It ships custom Paragraphs field widgets — an inline paragraphs previewer, a link-with-selected-attribute widget and a call-to-action widget/formatter — plus integration with view-mode selection, field groups and classy paragraphs so editors compose and style sections visually. Optional submodules extend it: `parade_demo` and `parade_pack` add demo content/feature settings (admin forms gated by `administer site configuration`), `parade_conditional_field` adds conditional fields to Paragraph types (gated by `administer paragraphs types`), and integration submodules provide Marketo forms/polls, a LinkedIn autofill helper and an aggregated Leaflet map. Its composer dependencies pull in paragraphs, geocoder/geofield/leaflet, view_mode_selector, classy_paragraphs, field_group and machine_name.

Operationally Parade is configuration- and content-model-heavy: you build Paragraph types and displays, then editors use the preview widgets on node forms. All administrative routes across the module and its submodules are permission-gated (`administer site configuration`, `administer paragraphs types`) with no anonymous or mutating public endpoints, so there is no notable request-facing security surface in the reviewed code.
---
- Build landing pages from reusable Paragraph components.
- Preview paragraph sections inline while editing a node.
- Add call-to-action fields with a dedicated widget and formatter.
- Configure link fields that carry a selected attribute/class.
- Switch section rendering via view-mode selection.
- Group fields visually in the editor with field_group.
- Apply preset CSS classes to paragraphs via classy_paragraphs.
- Install demo content to bootstrap a page-building setup (parade_demo).
- Enable extra features through the parade_pack submodule.
- Add conditional fields to Paragraph types (parade_conditional_field).
- Embed Marketo forms on pages (marketo_form submodule).
- Embed Marketo polls (marketo_poll submodule).
- Autofill forms from LinkedIn (linkedin_autofill submodule).
- Render an aggregated Leaflet map from geofield data.
- Geocode addresses via the geocoder integration.
- Compose multi-section marketing pages without custom theming.
- Give editors a component palette for page assembly.
- Reuse the same paragraph components across many pages.
- Style call-to-action blocks consistently site-wide.
- Manage demo/feature settings from admin config forms.
