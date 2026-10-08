# Preview (All Entity Preview) — manual setup guide

**Preview** — project name **All Entity Preview**, machine name **`preview`** —
extends Drupal's live preview beyond nodes. Core gives content nodes a *Preview*
button, but most other entity types get nothing: to see how a taxonomy term, a
media item, or a custom entity will look, an editor has to save it first and then
fix whatever is wrong. This module generalises preview to the entity types you
choose, and lets the previewer pick which **view mode** to preview in — so "how
will this look as a teaser?" can be answered before the entity is saved.

A useful thing to know up front: even though the project is called
`all_entity_preview`, its **machine name is `preview`**. That is the name you use
when enabling it and when reading its configuration.

It is a focused editorial-experience improvement. It adds no permissions of its
own beyond normal entity access — it only shows a preview of something the editor
could already edit. For the preview to be meaningful, make sure the view modes
you want to preview are actually configured for the entity types you enable it
on, since the preview renders whatever those view modes define.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (remember the machine name is `preview`).

## Where it lives in the admin menu

The module works on the entity edit forms themselves, adding a preview capability
for the entity types you enable it on, rather than adding a big central settings
screen.

## How to use it

1. Enable the module (machine name `preview`).
2. Confirm the entity types you want to preview have the relevant view modes
   configured (for example a *Teaser* view mode).
3. While editing one of those entities, use the preview to see how it will render
   in the chosen view mode before you save — cutting down on save-and-fix cycles
   for terms, media, custom entities, and other non-node content.
