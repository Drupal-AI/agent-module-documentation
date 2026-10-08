# Media Entity Datawrapper — manual setup guide

**Media Entity Datawrapper** (`media_entity_datawrapper`) adds a media source for
[Datawrapper](https://www.datawrapper.de/), letting editors embed Datawrapper
charts, tables, and maps as Drupal media entities. If you use Datawrapper (free or
paid), you paste the URL of a published chart into the media item and this module
handles the rest — embedding it as oEmbed content much the way core handles a
YouTube or Vimeo video. Once a chart is added, it can be reused through the Media
Library and inserted into CKEditor instances that allow entity embedding, just
like any other media entity.

The point of the module is to spare you from dealing with Datawrapper's iframe
embed code and its third‑party JavaScript by hand: you store a URL, and Drupal
treats the result as media. It depends only on Drupal core's Media module and runs
on Drupal 10 and 11.

Because the chart itself is remote content served from Datawrapper's servers, the
embed loads third‑party content in your visitors' browsers — an egress and privacy
consideration, since Datawrapper sees the visitors who load the visualisation. The
module adds no access‑control role of its own; media follows Drupal's normal media
access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

This module has no separate settings page. You set it up by creating a media type
that uses the Datawrapper source, described below.

## Where it lives in the admin menu

Media Entity Datawrapper adds no admin settings form. The media types you create
with the Datawrapper source appear under **Structure → Media types**
(`/admin/structure/media`), and individual visualisations are managed from
**Content → Media** (`/admin/content/media`) or through the Media Library.

## How to use it

1. **Create a media type that uses the Datawrapper source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), name it (for
   example "Datawrapper chart"), and in the **Media source** field choose
   **Datawrapper**. Save.
2. **Confirm the source field.** The media type will have a source field where the
   Datawrapper chart URL is stored; adjust its display on the **Manage display**
   tab if needed.
3. **Add a chart.** Go to **Content → Media → Add media**, choose your Datawrapper
   media type, and paste the URL of a **published** Datawrapper chart, table, or
   map. Save.
4. **Reuse it.** The chart is now in the Media Library and can be referenced from
   media reference fields or inserted through the CKEditor Media button wherever
   entity embedding is allowed.
