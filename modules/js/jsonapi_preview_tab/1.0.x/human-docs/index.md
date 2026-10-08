# JSON:API Preview Tab — manual setup guide

**JSON:API Preview Tab** (`jsonapi_preview_tab`) adds a **JSON:API Preview** tab to
the pages of nodes, media, taxonomy terms, and menu-link-content entities, showing
that entity's serialized JSON:API document inline — pretty-printed and
syntax-highlighted, with no browser extension required. It is a developer
convenience for decoupled and JSON:API-driven sites: rather than hand-constructing a
URL like `/jsonapi/node/article/{uuid}`, you open the tab on the entity's page and
see the highlighted JSON, plus a link to the live JSON:API URL.

It supports four entity types out of the box — `node`, `media`, `taxonomy_term`,
and `menu_link_content` — and builds on both core JSON:API and the
[JSON:API Extras](https://www.drupal.org/project/jsonapi_extras) module, whose
serializer it uses to produce the output. That makes it handy for confirming how
`jsonapi_extras` field overrides change what a resource looks like.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

There is **no settings form** for this module — the only control is the permission,
described below.

## Where it lives in the admin menu

The module adds no settings page. Its one control, **`access jsonapi preview
tab`**, lives at **People → Permissions** (`/admin/people/permissions`). Once
granted, the **JSON:API Preview** tab appears on the pages of supported entities.

## How to use it

1. Grant **`access jsonapi preview tab`** to trusted developer roles only.
2. Open a node, media item, taxonomy term, or menu link and click the **JSON:API
   Preview** tab.
3. Read the pretty-printed, syntax-highlighted JSON inline, or follow the link to
   open the live JSON:API URL in a new tab.
