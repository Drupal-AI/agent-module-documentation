# MILE (Menu Item Link Enhancer) — manual setup guide

**MILE (Menu Item Link Enhancer)** (`mile`) lets you replace a plain menu link —
just a label and a URL — with real, rendered Drupal content. Instead of showing a
line of text, a menu item can display a **block**, a **custom block content**
entity, or a **node**, using any available view mode. It's a lightweight way to
build rich, content-driven dropdown menus (previews, cards, promo panels,
calls-to-action) out of content you already have on the site.

The nice thing about MILE's approach is that it works *with* Drupal core rather
than overriding menu templates, and — unlike Menu Item Extras — it doesn't force
you to add extra fields to your menu items unless you actually want them. You edit
a menu link, pick some existing content to attach to it, choose the view mode, and
save. Layout and styling are left entirely to your theme, so you keep full control
without extra complexity (you'll usually add some CSS to make the dropdown look
right).

Under the hood it adds a "MILE references" fieldset to the menu-link edit form (for
users with the right permission), stores your choice on the menu link, and then at
render time reloads the referenced entity, builds it with your chosen view mode,
and drops the rendered output in place of the menu item's title. It works both in
themed menus and when a menu is built programmatically. It depends only on core's
**Menu Link Content** module. There's no separate settings page to fill in — you
work entirely from the menu-link edit form.

> **A note on visibility.** MILE renders the referenced entity into the menu
> markup, and menus are typically shown to everyone, including anonymous visitors.
> The reference is chosen at menu-edit time by a privileged user (gated by the
> *administer mile references* permission), so exposure is bounded by what that
> admin picks — but be deliberate: if a referenced node is later unpublished or
> made access-restricted, or you reference a low-visibility block content, its
> rendered content could still appear in the menu to users who otherwise couldn't
> see it. Treat *administer mile references* as a trusted permission and reference
> only content you're happy to show publicly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

There is **no dedicated configuration page** for this module. You attach content to
menu items directly on the menu-link edit form, described below.

## Where it lives in the admin menu

MILE adds no settings page of its own. You use it from **Structure → Menus**
(`/admin/structure/menu`): edit any menu link and you'll find a **MILE references**
fieldset on the edit form (if you have the *administer mile references*
permission). Grant that permission at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Grant the **administer mile references** permission to the roles that should be
   able to attach content to menu items (keep this to trusted editors).
2. Edit a menu link — for example under the **Main navigation** menu at
   **Structure → Menus**.
3. In the **MILE references** fieldset, choose what to attach:
   - a **block**, or
   - a **block content** entity (and pick its view mode), or
   - a **node** (and pick its view mode).
4. It's recommended to set the link value to `<nolink>` when you're replacing the
   item with an entity, so the label itself isn't a competing link.
5. Save the menu link.

On the frontend, that menu item now renders the referenced content instead of a
plain text link. Add custom CSS so the rendered content sits nicely inside your
menu/dropdown. Because MILE reloads the referenced entity at render time, the menu
always reflects the latest edits to that content.

> **Theming block content:** block content entities have no default theme wrapper,
> so MILE registers a `block_content_mile` theme with per-type and per-view-mode
> template suggestions
> (`block-content-mile--type-<type>[--<view_mode>].html.twig`) you can override in
> your theme.
