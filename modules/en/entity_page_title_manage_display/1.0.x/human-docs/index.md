# Entity Page Title Manage Display — manual setup guide

**Entity Page Title Manage Display** (`entity_page_title_manage_display`) gives
you a dedicated **"Page Title" view mode** so you can control what appears in the
page‑title area of an entity's full page — using the ordinary *Manage display*
tools you already know, instead of writing theme code.

On a normal Drupal site the page title is rendered by a core "Page title" block
and shows just the title text. This module lets you replace that block, per
entity type, with a configurable display. Once you customise the "Page Title"
view mode for a bundle and add fields to it, the full page of that entity renders
your configured view mode in the title area instead of the plain title. That
makes it easy to put a cover image, a section label, a subtitle, or any other
field right where the page title normally sits.

The module has no central settings screen. It works by adding the extra view
mode; the actual setup happens on each entity type's *Manage display* page, and
the replacement only takes effect for bundles where you have customised and
enabled that view mode. It depends only on Drupal core (10 or 11) and adds no
third‑party requirements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
All setup happens on your entity's *Manage display*, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin settings page of its own. You configure it entirely from
each entity type's display settings, for example **Structure → Content types →
*(your type)* → Manage display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** page of the entity/bundle you want to change —
   for a content type that is **Structure → Content types → *(type)* → Manage
   display**.
3. Open the **Page Title** display mode. If it isn't visible yet, expand the
   **Custom display settings** section at the bottom of Manage display, tick
   **Page Title**, and save.
4. On that Page Title display, add and arrange the fields you want to appear in
   the title area — the title itself plus, for example, a cover image, a section
   term, or a subtitle field. Set each field's format as usual.
5. Save. When you view a full page of that entity, the configured **Page Title**
   view mode replaces the default core page‑title block in the title area.
