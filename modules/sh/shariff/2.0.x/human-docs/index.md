# Shariff Sharing Buttons — manual setup guide

**Shariff Sharing Buttons** (`shariff`) adds privacy-friendly social share
buttons to your site. It integrates the Shariff widget from heise online, whose
whole point is that the buttons do **not** contact Twitter, Facebook, WhatsApp
and the rest until a visitor actually clicks them. That means no third-party
tracking cookies are dropped just because a page loaded — which is exactly what
GDPR-conscious sites want, and what a plain "official" share button from each
network cannot promise.

You place the buttons in two ways. There is a **block** ("Shariff share
buttons") you can drop into any region through *Block layout*, and there is a
per-node **display field** you switch on under *Manage display* so that share
buttons appear on your articles automatically. Both read from one global
settings form where you choose which networks appear, the color theme, the
orientation, and more. The module has no other Drupal module dependencies, and
access to its settings is gated by the core *Administer site configuration*
permission. If the optional **Metatag** module is installed, the node-view
buttons will use the Metatag title token as the share title.

One important requirement: Shariff relies on an **external JavaScript library**
(the heise online Shariff library, version 1.4.6 or newer) that you download and
place under `/libraries/shariff/` yourself. Until that library is present, Drupal
reports a requirements error and the buttons will not render fully — although all
of the *configuration* below works regardless. See
[Installation](installation/index.md) for how to add it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   add the external JavaScript library, and enable it.
2. [Configuration](configuration/index.md) — the global settings form, field by
   field, plus how to place the block and the node display field.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Web services → Shariff**
(`/admin/config/services/shariff`). You place the buttons from **Structure →
Block layout** (`/admin/structure/block`) for the block, and from **Structure →
Content types → [your type] → Manage display** for the per-node field.

## How to use it

The fastest path is to enable the module, add the library, then either place the
**Shariff share buttons** block in a sidebar or footer, or enable the
**Shariff sharing buttons** field on a content type's *Manage display* screen so
every node of that type shows the buttons. Both approaches pull their defaults
from the global settings form, and the block can override those defaults per
instance. See [Configuration](configuration/index.md) for the details.
