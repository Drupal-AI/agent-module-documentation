# Required Menu Link — manual setup guide

**Required Menu Link** (`required_menulink`) lets you make a menu link **mandatory
per content type**. Turn it on for a content type and, on that type's node form,
the *Provide a menu link* checkbox is forced on and the menu link **title** becomes
a required field — so every node of that type must have a menu link before it can
be saved. It's handy for navigational content types (landing pages, documentation
sections) that should always appear in a menu.

You control it from a **Menu link settings** vertical tab that the module adds to
the content type edit form. There you get three options: a hard *require a menu
link* toggle, a softer *don't enforce it, just pre‑enable the checkbox by default*
option, and a switch to *stop Drupal auto‑copying the node title into the menu
title* (so editors type a deliberate menu label instead). You can mix approaches
across content types — hard‑require on one, soft‑require on another.

A couple of practical notes. The enforcement is done at the **form level** — it
sets the menu checkbox and title as required/disabled on the standard node form.
That means it applies to the normal editing experience but does **not** add an
entity‑level constraint, so alternative save paths (REST, JSON:API, programmatic
node saves) aren't covered. The module has **no settings page of its own, no
permissions, and no services** — it's all driven from the content type form. It
depends on core's **Menu UI** module and runs on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the three per‑content‑type options
   and how they change the node form.

## Where it lives in the admin menu

There is no central settings page. You configure the requirement per content type
under **Structure → Content types → [your type] → Edit**
(`/admin/structure/types/manage/<type>`), in the **Menu link settings** vertical
tab.

## How to use it

Edit a content type, open the **Menu link settings** tab, tick *Require menu
link* (and optionally the other two options), and save. From then on, the node
add/edit form for that type forces a menu link and a menu title. The full
walkthrough is in [Configuration](configuration/index.md).
