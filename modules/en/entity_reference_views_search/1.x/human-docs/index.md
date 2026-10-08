# Entity Reference Views Search — manual setup guide

**Entity Reference Views Search** (`entity_reference_views_search`) gives editors
a richer way to fill in an entity reference field. Instead of a plain
autocomplete box, it embeds a **View** right inside the edit form so the editor
can search, filter, sort and page through candidate entities, then click a row to
select one — with an AJAX preview of the chosen entity rendered inline so they can
confirm they picked the right thing before saving.

The problem it solves is picking the right reference out of a large content set.
A bare autocomplete gives you only a title to go on; this widget lets you show
whatever context you want (thumbnails, extra fields, exposed filters) by pointing
the widget at a curated View. It ships a field widget, a Views field plugin that
adds a per-row "select" button, and a small JavaScript layer that wires the click
to the reference field. It depends only on core's **Field** and **Views** modules.

The module needs configuration to be useful: a global settings page controls
which field types the widget may attach to, and each field you want to use it on
must have its form widget switched to *Entity Reference Views Search* and pointed
at a View. It works on `string`, `email` and `entity_reference` fields by default.

A word of caution worth knowing before you deploy it: the AJAX preview endpoint is
gated only by the core *access content* permission and renders the requested
entity's default view mode without an additional per-entity view-access check. In
practice that means the preview can display renderable entities a user might not
otherwise see, so keep sensitive entity types out of the enabled field types and
out of your picker Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings page and how to
   attach the widget to a field.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Entity Reference Views Search**
(`/admin/config/entity-reference-views-search`) and needs the *Administer site
configuration* permission. The rest of the setup happens per field, on your
content type's (or other bundle's) **Manage form display** screen.
