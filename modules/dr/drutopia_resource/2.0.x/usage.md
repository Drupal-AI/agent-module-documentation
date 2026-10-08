<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feature module that installs a ready-made "Resource" content type and its supporting fields, taxonomy, search index, facets, views and display configuration.

---

A resource represents downloadable or referenced material — a file (e.g. a PDF), an external link (a website URL), or an embedded video — with body/summary text, an image, a resource-type taxonomy, tags and topics, and metatags. The module is configuration-only (a Features bundle, `bundle: drutopia`): it ships the `node.type.resource`, the field storage/instances (`field_resource_file`, `field_resource_link`, `field_resource_video`, `field_resource_type`, `field_body_paragraph`, image/media fields, summary, tags, topics), entity form/view displays (default, card, teaser, full, search_index, simple_card), a `resource_type` vocabulary, a Search API index, `resource_topics`/`resource_type` facets, a resources listing view, a block visibility group, pathauto pattern and rabbit hole settings. It has no PHP, routes, permissions or services of its own.

Because it is pure site-building configuration installed with the module, there is no runtime code path and no security surface introduced by this module itself — access to Resource nodes is governed by core node access and whatever permissions the site grants. Its long dependency list (Drutopia core/SEO, paragraphs, facets, search_api, ds, field_group, focal_point, media modify, video_embed_field, etc.) reflects the display/search stack it wires together; it is intended for the Drutopia distribution.

---
- Add a Resource content type to a Drutopia site
- Publish downloadable files (PDFs) as resources
- Publish external links as resources
- Embed videos as resources via video_embed_field
- Categorize resources with a resource-type taxonomy
- Tag and topic resources for filtering
- Provide a faceted resources listing (topics, type)
- Index resources in Search API for search
- Show resources as cards, teasers or full pages
- Apply pathauto URL patterns to resources
- Attach metatags/SEO to resource nodes
- Use paragraphs in the resource body
- Provide a resource listing view out of the box
- Control resource block placement via visibility groups
- Add focal-point cropped images to resources
- Build a resource library/knowledge base section
- Reuse Drutopia display conventions for resources
- Extend the resource type with additional fields
