# Entityform Block — manual setup guide

**Entityform Block** (`entityform_block`) lets you place a content entity's
**add or edit form** anywhere a block can go. Normally a "create" or "edit"
form only appears on its own dedicated route; with this module the same real
form becomes a block you drop into a region through the ordinary Block layout or
Layout Builder UI — a "submit an idea" form in a sidebar, an inline edit form on
a dashboard, or a contact-style entity form embedded in a landing page.

The block renders the genuine entity form: the same fields, the same validation,
and the same save behavior as the standard route. You are not rebuilding the
form, just relocating it, which saves you from writing a custom block plugin
every time you want a form somewhere unusual.

Because the block places a **real form that saves an entity**, access control is
the thing to get right. The module adds no access checks of its own beyond the
entity type's own create/edit permissions and the block's visibility settings —
so an add-form block dropped into a public region exposes entity creation to
anyone who can see that region. Always confirm that the block's visibility and
the entity type's permissions line up before you publish it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. You configure it
entirely by placing and configuring a block, described in "How to use it" below.

## Where it lives in the admin menu

Entityform Block adds no configuration page of its own. You work with it from
**Structure → Block layout** (`/admin/structure/block`) — or from Layout Builder
on a content type — where its form blocks appear in the *Place block* list.

## How to use it

1. Go to **Structure → Block layout**, choose a region, and click **Place
   block**.
2. In the block picker, select the **Entity form** block for the content entity
   and operation (add or edit) you want to expose.
3. Configure the block as usual — give it a label, set its region, and, most
   importantly, set its **visibility** so only the right users and pages see it.
4. Save the block layout. The entity form now renders in that region and behaves
   exactly like the standard form: it validates and saves the entity on submit.

> **Check access before you publish.** The block does not restrict who can
> submit the form beyond the entity type's create/edit permissions and the
> block's own visibility rules. Make sure those two align — an add form in a
> public region means anyone who can reach that page can create the entity.
