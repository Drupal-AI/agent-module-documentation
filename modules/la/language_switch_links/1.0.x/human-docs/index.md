# Language Switch Links — manual setup guide

**Language Switch Links** (`language_switch_links`) improves how the core
language‑switcher block reads. Out of the box the switcher shows each language's
name in a fixed form; this module lets the switcher links be labelled the way you
want — for example showing **"Español"** (the native name) rather than
"Spanish". The result is a switcher whose link text is clearer and friendlier for
the speakers of each language.

It is a small, focused display module. It depends only on core's **Language**
module, affects the switcher labels and nothing else, and has no content or
access‑control role. There is no elaborate setup — enable it and the switcher
labels are handled for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no dedicated configuration page** for this module — it has no settings
form. Its effect applies to the standard language‑switcher block once that block
is placed.

## Where it lives in the admin menu

Language Switch Links adds no admin page of its own. It works through the standard
**language‑switcher block**, which you place under **Structure → Block layout**
(`/admin/structure/block`). The link labels it produces can be adjusted through
Drupal's usual interface translation (**Configuration → Regional and language →
User interface translation**) where applicable.

## How to use it

1. Make sure your site has more than one language enabled under **Configuration →
   Regional and language → Languages**.
2. Place the **Language switcher** block in a visible region under **Structure →
   Block layout** if you have not already.
3. With Language Switch Links enabled, the switcher's link labels are rendered in
   the improved, native form automatically. Where you want to fine‑tune a specific
   label, use Drupal's interface translation for that language string.
