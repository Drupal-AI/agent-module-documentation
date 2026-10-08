# Linked Data Lookup Field — manual setup guide

**Linked Data Lookup Field** (`linked_data_field`) gives editors an autocomplete
field that draws its suggestions from an **external, authoritative data source**
rather than from your site's own content. As an editor types, the field queries a
remote endpoint — a SPARQL service, the Library of Congress authorities, or any
JSON API — and stores both the **label** they chose and its **URI**, so your
content is tagged with a stable external identifier that other systems recognise.

It ships ready to talk to several sources out of the box (Library of Congress
Subject Headings, the Global Research Identifier Database, and Australian/New
Zealand Standard Research Classification fields), and you can define your own.
Any endpoint that returns JSON can be wired up: you create a **Linked Data Lookup
Endpoint** configuration entity, choose an endpoint-type plugin (`SparqlQuery`,
`LoCAuthority`, or `URLArgument`), and point it at the source. Those endpoint
definitions are config entities, so you can export them and deploy them across
environments. The module is a generalisation of the older *LC Subject Field*
module and is widely used in Islandora and other repository/metadata setups.

Version 1.1 also adds a **taxonomy autocomplete** widget, so you can put a linked
data field on a taxonomy term and let editors either reference existing terms or
create new ones straight from the autocomplete.

A note on trust and safety: the autocomplete route is available to
**authenticated users only**, not anonymous visitors, and the endpoints it
queries are the ones an administrator configured — an editor controls only the
search text, not which host is contacted. Outbound requests go through Drupal's
HTTP client with normal TLS certificate verification.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define lookup endpoints and add a
   Linked Data field to your content.

## Where it lives in the admin menu

You manage lookup endpoints at **Structure → Linked Data Lookup Endpoint**,
where you can list, add, edit, and delete endpoint definitions. The field itself
is added and configured per bundle under **Structure → *(entity type)* → Manage
fields** and **Manage display**. See [Configuration](configuration/index.md).
