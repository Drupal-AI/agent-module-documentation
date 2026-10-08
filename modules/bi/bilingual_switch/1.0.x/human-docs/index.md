# Bilingual Switch — manual setup guide

**Bilingual Switch** (`bilingual_switch`) provides a block that shows a single link
toggling between the two languages of a bilingual site. Unlike core's language
switcher — which lists every enabled language — this block is purpose-built for
exactly two languages: it drops the current language and renders one compact link
pointing at the other, keeping the current path and query string intact.

The link carries a configurable prefix label (default "Switch to") and a Font
Awesome language icon, so it reads naturally in a header, for example "Switch to
Español". You can change the prefix per block instance to suit your wording, such as
"Ver en" or "View in".

The block is deliberately careful about when it appears: it only renders on
multilingual sites, and it renders **nothing** unless the current page has exactly
two language variants — so if a third language is ever enabled, the switcher quietly
disappears rather than showing something broken. It has no routes, permissions, or
services of its own; it is a presentational block only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Language).

## Where it lives in the admin menu

You place the block through **Structure → Block layout**
(`/admin/structure/block`), or via Layout Builder, by adding the **Bilingual
Language Switcher** block to a region. Its one setting — the prefix text — is
configured on the block itself when you place or edit it.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure your site has exactly two languages configured (the block hides itself
   otherwise).
3. Go to **Structure → Block layout**, place the **Bilingual Language Switcher**
   block in the region you want (for example the header), and optionally set the
   prefix label in the block configuration.
4. Standard block visibility conditions still apply, so you can restrict where the
   switcher shows. Because the block reflects the current language on every request,
   the link always points at the correct alternate language and preserves the
   visitor's current path and query string.
