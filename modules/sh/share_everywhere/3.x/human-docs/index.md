# Share Everywhere — manual setup guide

**Share Everywhere** (`share_everywhere`) adds **social share buttons** to your
content — Facebook like and share, X/Twitter, LinkedIn, Messenger, Viber, WhatsApp,
and a "Copy URL" button. Unlike the social networks' own drop‑in widgets, its
buttons are plain, themeable markup designed to blend into a custom theme, so they
won't clash with your design or drag in heavy third‑party scripts.

Everything is driven by a single settings page where you choose which buttons are
on, their order, labels and icons, a heading, alignment, whether the set is
collapsible behind a share icon, and whether the module's own CSS/JS is loaded. You
can surface the buttons in **four ways**: as an extra field on node and Commerce
product displays, inside the node's links area, as a placeable **block**, or as a
**Views field**. There's also a per‑entity mode that adds a "Show social share
buttons" checkbox to individual content so editors can opt in one item at a time.

Because each network has its own Twig template, you can restyle a single button
without touching the others, or swap in custom SVG icons to match your branding. The
module depends only on core's Path Alias; Commerce and Markdown are optional
integrations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the four ways to
   place buttons, per‑entity opt‑in, and turning off the bundled CSS/JS.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Share Everywhere**
(`/admin/config/services/share_everywhere`), gated by the **Administer share
everywhere** permission (`administer share everywhere`). Where the buttons actually
appear is then controlled from that form plus, for the extra‑field option, the
entity's *Manage display* page.
