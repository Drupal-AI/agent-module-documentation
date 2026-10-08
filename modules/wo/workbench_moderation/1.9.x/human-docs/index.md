# Workbench Moderation — manual setup guide

**Workbench Moderation** (`workbench_moderation`) adds an editorial publishing
workflow to Drupal content. Instead of a page being simply "published" or "not",
content moves through named **moderation states** — **Draft**, **Needs Review**,
**Published**, and **Archived** by default — along **transitions** you control.
Crucially, it keeps *forward* (draft) revisions separate from the live published
version, so an editor can work on a new draft of an already‑published page
without taking the live version down.

You turn moderation on **per content type** (or other bundle). Once enabled, a
bundle keeps revisions on, gains a **moderation state** selector on its edit
form, and gets a **"Latest version"** tab where reviewers can see the newest
draft. Which transitions a given user may perform is controlled by permissions —
each transition has its own `use <transition> transition` permission — so you can
map workflow steps to roles: authors may move Draft → Needs Review, editors may
move Needs Review → Published, and so on. That makes separation‑of‑duties
workflows (a second person must approve before publishing) straightforward.

The default four states and ten transitions cover most editorial needs, but both
states and transitions are configuration entities you can add to, so you can model
custom steps like "Legal review". The module also integrates with Views (a
"Latest revision" filter and moderation fields) and dispatches an event on each
moderated save for custom automation.

> **Note:** Workbench Moderation is the **contrib predecessor of core's Content
> Moderation** module. New sites usually prefer core Content Moderation, but many
> existing sites still run this module — this guide is for those sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn moderation on for a content
   type, adjust states and transitions, and assign the workflow permissions.

## Where it lives in the admin menu

- The moderation admin area is at **Structure → Workbench moderation**
  (`/admin/structure/workbench-moderation`), with sub‑pages for **States** and
  **Transitions**.
- Moderation is switched on per content type from a **Moderation** tab the module
  adds to each bundle's edit page (e.g. *Structure → Content types → Article →
  Moderation*).
- Workflow permissions are assigned at **People → Permissions**.

## How to use it

Enable moderation on the content types that need a workflow, decide which states
they may use and which state new content starts in, then grant each role the
per‑transition permissions that match their job. Editors then choose a moderation
state when they save, and the module decides whether that save updates the live
version or creates a forward draft. See [Configuration](configuration/index.md)
for the full walkthrough.
