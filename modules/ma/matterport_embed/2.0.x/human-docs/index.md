# Matterport Embed — manual setup guide

**Matterport Embed** (`matterport_embed`) places **Matterport 3D spaces and virtual
tours** into Drupal. A Matterport "showcase" is an interactive 3D walkthrough of a
physical space, hosted by Matterport; this module gives you a clean way to store a
reference to one and render it on your site as an embed.

It works as a proper field feature rather than a copy‑and‑paste block: it provides
its own **field type**, **widget** (for entering the Matterport reference when you
edit content) and **formatter** (for rendering the embedded tour on display). On top
of that you can define **custom styles** to control the embed's dimensions —
rectangle (e.g. 400×200), square (e.g. 500×500), or responsive (e.g. a 16/9 aspect
ratio) — and **custom option sets** that bundle Matterport URL parameters and a few
extra settings so you can reuse them across fields.

A couple of things to be aware of. This is an **unofficial** module for rendering
Matterport iframes, and the 3D tour itself is **third‑party content hosted by
Matterport** — it loads in the visitor's browser via an embed/iframe, so normal
third‑party‑embed considerations (privacy, consent, content policy) apply. The
module also has no access‑control role beyond the permission it provides; it does
not gate who can see an embedded tour on a page. Note too that its release is an
**alpha** on the 2.0.x branch and it targets **Drupal 11 only**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the field, choose the widget and
   formatter, and define styles and option sets.

## Where it lives in the admin menu

Matterport Embed doesn't add a single global settings page; you set it up on the
entities where you want a tour. Add a **Matterport Embed** field to a content type
(or other fieldable entity) under **Structure → Content types → *(type)* → Manage
fields**, then configure how it is entered and displayed under **Manage form
display** and **Manage display**.

## How to use it

1. Enable the module.
2. Add a **Matterport Embed** field to your entity.
3. Configure the **Matterport Embed Formatter** in the entity's display, choosing a
   style and (optionally) an option set.
4. Edit a piece of content, enter the Matterport showcase reference, and save — the
   3D tour renders on the display.
