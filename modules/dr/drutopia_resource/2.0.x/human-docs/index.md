# Drutopia Resource — manual setup guide

**Drutopia Resource** (`drutopia_resource`) installs a ready-made **Resource**
content type for a [Drutopia](https://www.drupal.org/project/drutopia) site,
together with the taxonomy, search index, facets, views and displays that make a
resource library work. A resource represents downloadable or referenced material
— a file such as a PDF, an external link, or an embedded video — with body and
summary text, an image, a resource-type taxonomy, tags and topics, and metatags.

Enable it and you get the `resource` node type with fields for a file
(`field_resource_file`), a link (`field_resource_link`) and a video
(`field_resource_video`), plus a `resource_type` vocabulary, a Search API index,
`resource_topics` and `resource_type` facets, a resources listing view, a block
visibility group, a Pathauto pattern and Rabbit Hole settings. View displays
include default, card, teaser, full, simple card and a search-index display.

Everything is site-building configuration — there is no custom code, no routes
and no permissions of its own — so access to Resource nodes follows core node
access and whatever permissions you grant. Its long dependency list reflects the
display and search stack it wires together. It builds on
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md) (and works
alongside Drutopia SEO), Media, Taxonomy, Facets, Paragraphs, Search API,
Pathauto and Video Embed Field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its media, facets and search dependencies.

## Where it lives in the admin menu

There is no settings form. The Resource content type appears under **Structure →
Content types** (`/admin/structure/types`); create resources from **Content → Add
content → Resource** (`/node/add/resource`). The search index and facets are
managed under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and the Facets admin.

## How to use it

Add a resource and provide whichever material it represents — a file, an external
link, or an embedded video — then categorise it with a resource type, tags and
topics. Index resources in Search API so the faceted listing can filter them by
topic and type. Grant the usual node permissions for the `resource` bundle to
control who can create and edit resources, and adjust the displays or extend the
type with extra fields as needed.
