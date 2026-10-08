# Advanced Datalayer — manual setup guide

**Advanced Datalayer** (`advanced_datalayer`) builds the JavaScript
`window.dataLayer` object — the data structure Google Tag Manager reads — from
configurable "tags," and pushes it into the page head on every supported route.
Instead of hard‑coding analytics variables into your theme templates, you define
them once as tags, give each tag a value (often built from **tokens** like
`[node:title]`), and set different values per page type. It's aimed at SEO and
analytics work: getting structured page metadata into GTM cleanly and keeping it in
exportable configuration.

The module is a **framework**: it defines two plugin types — **datalayer tags** and
**datalayer groups** (which nest tags into structured objects) — but ships **no tags
of its own**. You get tags either from the bundled example submodule or from plugins
you (or a developer) write. Once tags exist, site builders assign values to them per
**page context** — global, front page, node pages, taxonomy terms, 403/404, login,
register, and password‑reset pages — through the admin UI. A tag's value is usually a
token string, resolved at request time against the current page's entity, so the
same tag can emit a different value on every node.

At output time the module gathers the applicable tags (global plus the current page
type, plus any values an individual entity carries via its own datalayer field),
lets other modules alter the result, and injects the `dataLayer` push into the page
head. A field type, widget, and formatter let individual entities carry their own
per‑entity tag values on top of the context defaults.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the plugin
annotations and the generation/injection services — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and add tags (via the example submodule or your own).
2. [Configuration](configuration/index.md) — assign tag values per page context,
   use tokens, and add per‑entity values.

## Where it lives in the admin menu

The page‑variable configuration lives at **Configuration → Search and metadata →
Advanced Datalayer → Page variables**
(`/admin/config/search/advanced-datalayer/page-variables`), with add/edit/delete
forms and a settings form. Everything there is gated by the **Administer advanced
datalayer defaults settings** permission. The module adds no Drush commands.

## How to use it

1. **Get some tags.** Out of the box there are none — enable the
   `example_advanced_datalayer` submodule for ready‑made tags (siteName, pageName,
   pageCategory, event, responseCode, gaClientID, …), or have a developer write
   `@AdvancedDatalayerTag` / `@AdvancedDatalayerGroup` plugins.
2. **Assign values per page context** on the Page variables screen — for example set
   a global `siteName`, and a `pageName` of `[node:title]` on the node context.
3. **Optionally let editors set per‑entity values** by adding the `advanced_datalayer`
   field to a bundle.

Full step‑by‑step details are in [Configuration](configuration/index.md).
