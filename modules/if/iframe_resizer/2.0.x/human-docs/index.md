# iFrame Resizer — manual setup guide

**iFrame Resizer** (`iframe_resizer`) wires the third-party
[iframe-resizer](https://github.com/davidjbradshaw/iframe-resizer) JavaScript
library (version 4.x) into Drupal so that iframes keep themselves sized to their
content. Instead of a fixed-height iframe with an inner scrollbar, the frame grows
and shrinks to fit whatever it contains — with support for cross-domain frames,
in-page anchor links, and nested frames.

The whole module is driven from one admin settings form; it adds no field and no
block. It handles two independent roles, and you turn on whichever you need:

- **Host** — *your* site embeds resizable iframes. The module loads the resizer
  library and initialises it, either on all iframes or on a set of CSS selectors you
  choose.
- **Hosted** — *your* site is shown inside someone else's resizable iframe. The
  module loads the "content window" script so the parent site can size your page,
  and lets you restrict which parent domain may embed you.

One important prerequisite: the iframe-resizer JavaScript library is **not bundled**
with the module — you must install it yourself (version 4.x; version 5.x is a
commercial release and is not supported). Until the library is present, the site's
status report shows an error. The configuration UI is gated by a dedicated
**Administer iframe resizer** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module *and* the required
   iframe-resizer 4.x library, then enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field: host
   vs hosted modes, targeting, and the advanced library options.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → iFrame Resizer**
(`/admin/config/user-interface/iframe_resizer`), reachable by anyone holding the
**Administer iframe resizer** permission.

## How to use it

After installing the module and the library (see
[Installation](installation/index.md)), open the settings form and enable at least
one of the two usage modes — the module does nothing until you do. For the common
case (embedding resizable iframes on your own site), tick **Host**, decide whether to
target all iframes or specific selectors, and save. Full field-by-field guidance is
in [Configuration](configuration/index.md).
