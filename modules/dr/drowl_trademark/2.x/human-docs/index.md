# DROWL Trademark — manual setup guide

**DROWL Trademark** (`drowl_trademark`) automatically appends a registered
trademark sign — a superscript ® — after specific words wherever they appear on
your rendered pages. You list the words you want marked (as a comma‑separated
list) on the module's settings form, and the module adds the symbol at runtime
using JavaScript, so you never have to edit your content to keep trademark marking
consistent across the site.

The approach is deliberate: because it works in the browser rather than as a text
input filter, it also catches words that come from places without input filtering,
such as the menu system. The trade‑off is that the marking is applied client‑side
by JavaScript. The module has no dependencies and provides one permission for
administering its settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the list of words to mark.

## Where it lives in the admin menu

DROWL Trademark provides a settings form where you enter the words to mark. After
enabling the module, open its configuration from the module's entry on the
**Extend** page (`/admin/modules`) via its **Configure** link, or find it under
**Configuration**. See [Configuration](configuration/index.md) for details.
