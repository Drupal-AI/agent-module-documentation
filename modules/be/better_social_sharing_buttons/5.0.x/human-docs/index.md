# Better Social Sharing Buttons — manual setup guide

**Better Social Sharing Buttons** (`better_social_sharing_buttons`) adds a row of
lightweight social **share** buttons to your pages — Facebook, X, LinkedIn,
WhatsApp, Bluesky, email, "copy link", and about a dozen more. Its selling point
is privacy: each button is a plain link to the network's own share URL, opened in
a new tab. There are **no tracker scripts, no ad‑server calls, and no external
JavaScript** — and all the icons come from a single inlined SVG sprite that loads
once, so the buttons add almost nothing to page weight.

You can place the buttons three ways: as a **block** (drop it into a sidebar or
footer region), as a **pseudo‑field** on nodes and paragraphs (arrange it in the
content type's display), or printed directly in a Twig template with Twig Tweak.
A global settings form controls which networks appear and in what order, the icon
style, size, and corner radius. The same options also appear on each block
instance, where they override the global defaults for that one placement.

Because share links carry the current page's URL and title, the buttons are meant
for canonical content pages. Two networks need a little extra setup before they
work: **Facebook Messenger** requires a Facebook App ID, and the **Print** button
requires a print stylesheet. A companion submodule,
**better_social_sharing_buttons_per_node**, lets editors turn the buttons on or
off on individual nodes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional submodule.
2. [Configuration](configuration/index.md) — the global settings form, field by
   field, plus how to place the block and expose the fields.

## Where it lives in the admin menu

The global settings form is at **Configuration → Web services → Better Social
Sharing Buttons settings**
(`/admin/config/services/better_social_sharing_buttons/config`). It is gated by
the core **Administer site configuration** permission — the module adds no
permission of its own.

## How to use it

The quickest way to get buttons on the page is the block: go to **Structure →
Block layout** (`/admin/structure/block`), place the **Better Social Sharing
Buttons** block into a region, and (optionally) tweak its networks/size right on
the block form. For the global defaults, the field‑by‑field settings, and the
node/paragraph field and Twig options, see
[Configuration](configuration/index.md).
