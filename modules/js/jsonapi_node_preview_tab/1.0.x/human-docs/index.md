# JSON:API Node Preview Tab — manual setup guide

**JSON:API Node Preview Tab** (`jsonapi_node_preview_tab`) adds a **JSON:API** tab
to node pages that shows you the exact JSON:API document a given node produces —
without hand-building the `/jsonapi/node/{bundle}/{uuid}` URL yourself. It solves a
small but constant need while building a decoupled or JSON:API-consuming front end:
you want to see the real API representation of the content you are editing, right
there on the node.

The tab lives at `/node/{node}/json-preview` and embeds the node's canonical
JSON:API individual endpoint in an `<iframe>`. There is also a matching "JSON"
entity-operation link, so you can jump to a node's JSON:API document straight from
the admin content listing.

Access to the tab is gated by a single permission, **`access jsonapi preview
tab`** — the tab and the entity-operation link are both hidden from users who lack
it. Importantly, the iframe points at the standard JSON:API endpoint, so JSON:API's
own entity-access enforcement still applies inside the frame: granting the
preview-tab permission does **not** bypass node access or expose unpublished
content that JSON:API would otherwise withhold. Grant it to the editor and
developer roles that need it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

There is **no configuration page** for this module — the only thing to set is the
permission, described below.

## Where it lives in the admin menu

The module adds no settings page. Its one setting is the **`access jsonapi preview
tab`** permission, granted at **People → Permissions**
(`/admin/people/permissions`). Once granted, the **JSON:API** tab appears on every
node's page.

## How to use it

1. Grant **`access jsonapi preview tab`** to the roles that should see it (editors
   and developers, typically).
2. Open any node and click the **JSON:API** tab, or use the **JSON**
   entity-operation link from **Content** (`/admin/content`).
3. The node's JSON:API document renders in an embedded frame — inspect field
   structure, attribute names, and relationship references without writing a
   client.

> **Tip:** browsers vary in how they display raw JSON in an iframe. In Chrome, the
> JSONVue extension (with "format contents in frames" enabled) pretty-prints the
> output; some browsers, such as Firefox, may try to download the JSON instead —
> that is a browser display quirk, not a module setting.
