# Node Option Premium — manual setup guide

**Node Option Premium** (`nopremium`) adds a **Premium content** option to nodes,
alongside core's publishing options (Published, Promoted, Sticky). When a node is
marked premium, users who lack the right permission see only its **teaser** — even
when they open the full page — together with a message inviting them to gain
access. It's the classic pattern behind a soft paywall or a members‑only teaser,
and it's positioned as an actively maintained alternative to the old, unmaintained
*Premium* module. (Don't install both.)

It depends only on core's **Node** module. Setup is mostly a matter of
**permissions**: for each content type it provides a *view full [type] premium
content* permission (who may see the whole thing) and an *override premium option*
permission (who may toggle the flag while editing). It also exposes two node
operations — *Make content premium* and *Make content non‑premium* — a Views
field/filter/sort, a Rules condition, and a per‑content‑type message you can
customise and theme.

**The single most important thing to understand: this is a *display‑layer*
restriction, not access control.** It works by swapping the view mode to the
teaser for unprivileged users (via `hook_entity_view_mode_alter()`); it does
**not** implement any node‑, entity‑ or field‑access hook. The node therefore stays
fully view‑accessible and its field values are unchanged, so any path that loads
the node and reads its fields — JSON:API, REST, Views fields, feeds — can return
the full "premium" content. The teaser on the web page is a presentation choice; the data is
not protected. Use it for its honest purpose: showing non‑subscribers a teaser to
encourage sign‑up on a site where the premium content is **not actually secret**.
If content must genuinely be withheld (paid or private material), this module does
not do that — you need real field/node access control plus disabling or filtering
JSON:API/REST for the affected types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the permissions, learn the access
   model, mark nodes premium, and customise the message.

## Where it lives in the admin menu

The premium flag appears in the **Publishing options** area of each node's edit
form. The permissions are set at **People → Permissions**
(`/admin/people/permissions`), and the per‑content‑type non‑premium message is
customised at **Configuration → Workflow → Node Option Premium**
(`/admin/config/workflow/nopremium`).
