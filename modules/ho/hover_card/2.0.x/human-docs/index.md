# Hover Card — manual setup guide

**Hover Card** (`hover_card`) shows a small, elegant popup card with a user's
details whenever a visitor hovers over a link to that user — for example the
author name on a post or a comment. Instead of clicking through to the full user
page, the reader gets a quick, in‑place card with the person's picture, name, and
whichever fields you choose to reveal. Version 2.0 is a modern rewrite built on the
[Tippy.js](https://atomiks.github.io/tippyjs/) tooltip library, with a clean,
accessible, keyboard‑friendly card and theme‑agnostic BEM CSS.

The card is highly configurable. You decide which pieces of information appear —
user picture, email, roles, "member since", last access — and the module even
**discovers custom user fields automatically**, so any extra fields you've added to
the user entity (a bio, a job title, a link) can be switched on for display. User
data is fetched lazily, only on hover, so there's no performance cost to pages that
are never hovered. An advanced setting lets you change the **CSS selector** that
decides which links trigger a card.

Access is governed by a granular permission system: a **View hover cards**
permission (which you can extend to anonymous visitors if you wish) and an
**Administer Hover Card settings** permission for configuration.

> **Privacy matters here.** A hover card displays real user profile data. Only
> enable fields that are safe to reveal to whoever will see the card — think
> carefully before exposing email addresses or other sensitive fields, especially
> if the card is visible to anonymous visitors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   clear caches.
2. [Configuration](configuration/index.md) — grant the permission, choose which
   fields the card shows, and tune the advanced settings.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Hover Card**
(`/admin/config/people/hover-card`). Permissions are granted on the usual
**People → Permissions** page.
