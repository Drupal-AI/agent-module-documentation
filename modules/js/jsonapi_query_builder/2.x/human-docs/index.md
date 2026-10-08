# JSON:API Query Builder — manual setup guide

**JSON:API Query Builder** (`jsonapi_query_builder`) provides a modern, interactive
interface for exploring and building Drupal JSON:API requests. Constructing
JSON:API query URLs by hand — filters, includes, sparse fieldsets, sorting,
pagination — is fiddly and error-prone. This module gives developers and site
builders a visual way to assemble those queries, discover what a site exposes, and
test requests without hand-writing complex query strings.

It can discover the entity types and bundles available on your site, then let you
build a query with all the supported parameters: selective **fields**, related
**includes** (with dot notation for related entity fields), **filters** with
various operators, **sorting** with direction, and **pagination**. It displays the
formatted, syntax-highlighted response, lets you copy the constructed URL or a
ready-to-run **cURL** command, keeps a **history** of previous queries, and lets you
**bookmark** favorites. There is also authentication documentation to help you wire
requests into your own code.

This is a **developer tool**. It builds queries against your site's JSON:API but
does not bypass access — JSON:API's own access controls still govern what any query
can actually return. Keep the builder gated to admin/developer roles: exposing an
API query builder to untrusted users offers no benefit, so enable it when you need
it and keep it restricted otherwise.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no settings form** for this module — you use its interactive builder
interface directly, and access is governed by the usual administrative permissions.

## Where it lives in the admin menu

The module provides an interactive builder interface rather than a settings page.
Reach it from the administrative navigation once the module is enabled; keep it
restricted to trusted admin/developer roles.

## How to use it

1. Open the query builder interface as an administrator/developer.
2. Pick an entity type and bundle from the discovered options.
3. Add the parameters you need — fields, includes, filters, sort, pagination — and
   watch the constructed JSON:API URL update.
4. Run it to see the formatted, highlighted response; copy the URL or the generated
   cURL command into your code; and bookmark or revisit queries from the history as
   you iterate.

Because JSON:API enforces its own access, a query you build here returns only what
the current user is allowed to see — the builder is a convenience for constructing
URLs, not a way around access control.
