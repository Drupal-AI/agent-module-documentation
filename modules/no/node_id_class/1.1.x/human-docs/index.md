# Node ID Class — manual setup guide

**Node ID Class** (`node_id_class`) gives themers and site builders dynamic CSS
hooks on their content. It lets you attach custom **IDs and classes** to two
places — the `<body>` element on a full node page, and the node's own wrapper in
every view mode and listing — and to build those class and ID strings from
**tokens** that describe the node. Instead of writing a preprocess function to add
`node-42 article body-author-7` to markup, you configure it once per content type
in the admin UI.

The tokens you can weave into the strings are `{node_id}`, `{node_title}` (turned
into a URL‑friendly slug), `{bundle}` (the content type machine name), and
`{node_author_uid}` (the author's user ID). So a body ID of
`body-id-{node_id}-{bundle}` becomes something like `body-id-42-article` on the
page, giving you a precise, meaningful hook to target from CSS or JavaScript for
unique layouts and per‑node styling. The module sanitizes and escapes token
values automatically — HTML is stripped and titles are machine‑safed — to keep the
markup valid and to avoid injection.

It is a content‑display / theming feature only; it has no access‑control role and
depends solely on core's **Node** module. There is no central settings page —
configuration lives on each content type — so once installed you set it up type by
type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration happens per content type rather than on a central settings page — see
"How to use it" below.

## How to use it

1. Go to **Structure → Content types** and click **Edit** on the content type you
   want to add classes to (for example `/admin/structure/types/manage/article`).
2. Find the new **Node ID Class** fieldset on that page. It has three fields:
   - **CSS Body ID** — applied to the `<body>` element on full node pages. Supports
     the tokens above. Example: `body-id-{node_id}-{bundle}-{node_title}`.
   - **CSS Body Class(es)** — applied to the `<body>` element; separate multiple
     classes with spaces. Example: `body-class-{node_id}-{bundle}`.
   - **CSS Node Class(es)** — applied to the node wrapper in *all* view modes and
     listings (including Views); separate multiple classes with spaces. Example:
     `node-class-{node_id}-{bundle}-{node_title}`.
3. Save the content type, then view a node of that type to confirm the classes
   appear.

> **Troubleshooting:** Tokens are only replaced when viewing a node, and body ID /
> body classes only apply on full‑page node views. If classes do not appear, make
> sure the node is shown in a full‑page view mode and that your theme prints
> `$attributes` (and `$content_attributes` where relevant). HTML is intentionally
> stripped from these fields for security, so only plain class/ID text and the
> supported tokens are honored.
