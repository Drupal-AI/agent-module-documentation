# Apigee API Catalog — manual setup guide

**Apigee API Catalog** (`apigee_api_catalog`) publishes API documentation to your
developers. It models each documented API as a Drupal node of type **`apidoc`**,
which holds an OpenAPI specification — either uploaded as a file or fetched from a
remote URL — and renders it as browsable reference documentation. It is aimed at
Apigee developer portals, but the `apidoc` node type works on its own without a
live Apigee connection.

Each API doc node carries the fields that make specification handling work: the
spec itself, whether it was uploaded or fetched, the remote URL, a checksum and
timestamp of the last fetch (so the module can tell when an upstream spec actually
changed), and a reference to the Apigee API product it belongs to. A **Re-import**
operation appears on each node so editors can pull a fresh copy of the spec when
the source changes; it rides on ordinary node-edit access, so anyone who can edit
the node can re-import it.

Three experimental submodules extend the catalogue beyond OpenAPI: **AsyncAPI**
for event-driven APIs, **GraphQL** for GraphQL APIs, and **Free-form** for
hand-written documentation alongside the generated specs.

This module ships only core dependencies and adds no configuration form and no
permissions of its own — it relies on ordinary Drupal node permissions. Setup is
mostly a matter of enabling it and then creating `apidoc` content.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the experimental submodules you need.

## How to use it

1. After enabling the module, go to **Content → Add content → API Doc** and
   create an `apidoc` node for each API you want to publish.
2. Choose the spec source — **upload** a specification file, or point the node at
   a **remote URL** for the module to fetch.
3. Save the node. The module stores the spec and records a checksum and fetch
   timestamp so it can detect later changes.
4. When the upstream definition changes, use the **Re-import** operation on the
   node (or the `/node/{node}/reimport` route) to pull a fresh copy. This is
   available to anyone who can edit that node.
5. Optionally associate each doc with an Apigee API product via the
   `field_api_product` reference — this is the field that ties a doc to Apigee
   itself.

Because the catalogue is built from ordinary nodes, you control who can view,
create, edit and re-import docs through normal Drupal content permissions.
