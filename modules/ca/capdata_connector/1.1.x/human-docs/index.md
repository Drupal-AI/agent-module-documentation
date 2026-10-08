# CapData connector — manual setup guide

**CapData connector** (`capdata_connector`) exports your Drupal site's data as an
RDF file for open‑data and linked‑data consumption. It exposes an endpoint that
generates an RDF representation of the site's data — the kind of feed consumed by
open‑data platforms (it is commonly used with French agricultural/open‑data
services such as CapData). It supports Drupal 10.2+ and 11 and declares its own
permission.

The key thing to understand before you deploy it: the RDF export endpoint at
`/rof/capdata-rdf-export` is **anonymous by design**, because open data is meant
to be publicly consumable. That means whatever the export includes is exposed to
anyone who requests the URL. Make sure only the data you intend to publish — and
nothing sensitive — ends up in the export.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

CapData connector adds no settings form of its own. Its working surface is the RDF
export endpoint at `/rof/capdata-rdf-export`, which is publicly accessible. The
module declares a permission, so review it at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

Enable the module and request `/rof/capdata-rdf-export` to retrieve the RDF export
of your site's data, ready for an open‑data or linked‑data consumer to ingest.
Because that endpoint is public, review exactly what it exposes and confirm it
contains only data you are comfortable publishing openly before pointing any
consumer at it.
