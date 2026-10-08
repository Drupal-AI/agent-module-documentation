# JSON:API Links — manual setup guide

**JSON:API Links** (`jsonapi_links`) removes the `links` members from Drupal's
JSON:API responses to make them smaller and less noisy. JSON:API is a HATEOAS
format: by design, every resource, relationship, and collection carries `links`
telling a client where to go next. That is the specification working as intended —
but on a Drupal site those links are also a substantial share of the payload. A
collection of fifty nodes with several relationships each emits links for all of
them, and a front end that constructs its own URLs reads none of it.

Removing the links is a size-and-noise decision: responses get materially smaller,
and what remains is the data the client actually uses. You toggle the behavior
from a single checkbox on a settings form. There is one deliberate exception —
requesting `/jsonapi` (the API root path) still returns its links untouched, so
discovery of the API entry point keeps working.

Two things are worth being deliberate about, because this deviates from a
specification. First, a **generic** JSON:API client — a library or tool that
discovers the API rather than hard-coding its URLs — may depend on those links, so
stripping them is safe for a front end you control and risky as a blanket setting.
Second, `links` includes the **`self`** link, which is often how a client
re-fetches or invalidates a single resource; a front end relying on that will
break in a way that looks unrelated to this module.

There is a small, honest security-adjacent benefit: because `links` reveal the
shape of the API (related resource paths, collection URLs, pagination structure),
removing them makes casual enumeration slightly harder. That is **obscurity, not
access control** — the resources are still there and still reachable. Use
`jsonapi_permission` or entity access for the real boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the single "Remove all links
   attributes" setting.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → JSON:API → Links**
(`/admin/config/services/jsonapi/links`). It requires the **Administer site
configuration** permission.
