# Vanta Modifier — manual setup guide

**Vanta Modifier** (`modifiers_vanta`) adds an animated WebGL background — the
kind of drifting waves, birds, net, or fog effect you may have seen on landing
pages — to elements on your site, using the third-party
[Vanta.js](https://www.vantajs.com/) library. It is an addition to the
[Modifiers](https://www.drupal.org/project/modifiers) styling framework, so the
effect is applied the "modifier" way: as configurable presentation attached to a
component, not as hand-written JavaScript.

On install it creates a new **Paragraph bundle**. You reference that bundle from
an Entity Reference Revisions field named **`field_modifiers`** on a block,
paragraph, or on a [Look](https://www.drupal.org/project/look). The Modifiers
module reads the paragraph's values and, through this module's `VantaModifier`
plugin, emits the target CSS selector plus the Vanta effect settings (effect type,
colours, media queries) so a JavaScript behavior turns them into a live animated
background. The module adds no routes, permissions, or services — it is purely a
render-time modifier plugin — and it plays no access-control role.

It depends on the **Modifiers**, **Paragraphs**, and core **Options** modules,
and it requires the **Vanta.js** JavaScript library to be present on the site (the
module only attaches the library; it does not bundle it). It runs on Drupal 9, 10,
and 11 and is maintained by Morpht. Because there is no settings page — you
configure each effect as paragraph field values — this guide folds setup into this
page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Vanta.js
   library, then enable it.

There is **no configuration page** for this module. You configure each animated
background as paragraph field values, as described in "How to use it" below.

## Where it lives in the admin menu

Vanta Modifier adds no admin settings page. You work with it on the content,
blocks, or paragraphs that carry a **`field_modifiers`** field, where you add the
Vanta Modifier paragraph and set its options.

## How to use it

1. Install the module **and** the Vanta.js library (see
   [Installation](installation/index.md)) — the effect will not render without the
   library.
2. Add an **Entity Reference Revisions** field named **`field_modifiers`** to the
   block or paragraph you want to decorate (or use a Look), and allow it to
   reference the Vanta Modifier paragraph bundle the module created.
3. On the host entity, add a **Vanta Modifier** paragraph and configure it:
   - Choose a **Vanta effect** (for example waves, birds, net, or fog).
   - Set the **base/background colour** and the **highlight/secondary colour**.
   - Optionally restrict the animation to a **CSS selector** on the host element.
   - Optionally apply the effect only within a **media query** breakpoint (for
     example, disable it on small screens).
4. Save the host entity. The animated background renders behind that component.
   Layer readable content over it, and reuse the same effect configuration across
   multiple components as needed. Removing the modifier drops the animation
   without deleting the host content.
