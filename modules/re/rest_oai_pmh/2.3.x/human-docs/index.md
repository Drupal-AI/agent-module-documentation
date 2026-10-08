# REST OAI-PMH — manual setup guide

**REST OAI-PMH** (`rest_oai_pmh`) turns a Drupal site into a standards‑compliant
**OAI‑PMH 2.0 repository**. OAI‑PMH is the harvesting protocol used by libraries,
archives, and digital‑library aggregators to pull metadata from each other. With
this module, harvesters and discovery systems (union catalogs, VuFind, Primo,
BASE, DPLA‑style hubs, and so on) can retrieve your content as Dublin Core, MODS,
or a custom XML schema from a single endpoint at `/oai/request`.

Rather than exposing entities directly, the module works through **Views**: you
pick one or more Views (each built as an *Entity Reference* display) on the
settings form, and a background job indexes their results into a set of internal
tables. Each selected View becomes an OAI **set** (a named grouping harvesters can
request selectively) — or, if a View's display uses an entity‑reference contextual
filter, each referenced entity (like a collection term) becomes its own set. The
endpoint then answers the six OAI verbs — `Identify`, `ListMetadataFormats`,
`ListSets`, `ListIdentifiers`, `ListRecords`, and `GetRecord` — from that index.

Two things are worth knowing up front. First, **access is re‑checked live**: even
though records are indexed from a View, every harvest response re‑checks each
entity's and field's view access as the requesting (usually anonymous) user, so
unpublished or restricted content is filtered out rather than leaked. Second, the
endpoint is a normal core REST resource, so a fresh install returns **403 until
you grant the `restful get oai_pmh` permission** — usually to the anonymous role,
since harvesters connect anonymously.

How records are rendered into XML is pluggable (the **OaiMetadataMap** plugin type
— Dublin Core from RDF or Metatag, MODS, or raw), as is how the index stays fresh
(the **OaiCache** strategy — *liberal* vs *conservative*). Extending those is
developer territory covered in the [agent docs](../agent/start.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set up a metadata source.
2. [Configuration](configuration/index.md) — grant the endpoint permission, choose
   Views/sets, set repository details and metadata formats, and build the index.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → REST → OAI‑PMH**
(`/admin/config/services/rest/oai-pmh`), gated by the **Administer REST resources**
permission. The manual index rebuild form is at
`/admin/config/services/rest/oai-pmh/queue`. The public endpoint answers at
`/oai/request` (the path is configurable).
