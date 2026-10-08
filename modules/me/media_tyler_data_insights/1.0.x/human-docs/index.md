# Media: Tyler Technologies Data & Insights — manual setup guide

**Media: Tyler Technologies Data & Insights** (`media_tyler_data_insights`) lets
editors embed Tyler Technologies **Data & Insights** (Socrata) visualizations — the
charts, maps, dataset tables and stories used by many public-sector open-data sites —
as first-class Drupal **Media**. Editors paste the share/embed snippet Data & Insights
gives them, and the module turns it into a governed, reusable iframe embed anywhere
Media is used.

It works by adding a **media source** ("Tyler Data & Insights") backed by a long-text
field that stores the pasted snippet, plus a matching **field formatter** that pulls
the iframe out of the snippet and renders it at a width and height you set. Because the
embed lives in a Media entity, you get all the usual benefits: it can be added through
the Media Library, referenced from many nodes, dropped into a WYSIWYG body with the
media button, placed in a Layout Builder block, and swapped site-wide by editing one
entity.

Safety is built in. A validation rule rejects any snippet that doesn't contain exactly
one iframe, whose path isn't a valid Data & Insights `/w/…` or `/stories/…` URL, or
whose host isn't on your **allowed hosts** list — so editors can't paste arbitrary
external iframes. The allowed-hosts list is the module's only configuration, and if you
run the CSP module those hosts are added to the `frame-src` policy automatically so the
embeds load. The module depends on core **Media**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the allowed-hosts settings form, the
   only settings the module has.

## How to use it

1. **Create a media type** whose **source** is **Tyler Data & Insights**
   (**Structure → Media types → Add media type**).
2. **List your Data & Insights domains** in the allowed-hosts settings so embeds from
   them validate — see [Configuration](configuration/index.md).
3. **Grant permissions:** normal core Media permissions govern who can create media of
   this type; the separate *Administer allowed hosts* permission governs who edits the
   host list.
4. **Add content:** create a media item of that type and paste the Data & Insights
   share/embed code. Once saved, reference or embed it wherever you need the
   visualization.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Tyler Data & Insights**
(`/admin/config/media/tyler-data-insights`). The media type is created under
**Structure → Media types**.
