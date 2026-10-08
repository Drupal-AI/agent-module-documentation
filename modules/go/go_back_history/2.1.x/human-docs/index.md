# Go Back History — manual setup guide

**Go Back History** (`go_back_history`) provides a single **block** that renders a
"go back to the previous page" link, driven by the visitor's own **browser
history**. You place it through Drupal's normal block layout, wherever a
"take me back" affordance would help.

Getting a visitor back where they came from is trickier than it sounds. A
breadcrumb shows structural position, not the path someone actually took; a
hard-coded link to a listing page is wrong when the visitor arrived from search or
a related item. The browser's history is the only thing that truly knows where they
were — and this module surfaces it as a block, so you can place it per region, per
theme, and restrict it with the usual block visibility conditions.

That makes it a good fit for detail pages reached from many directions — a product
opened from a category, a search result, or a promotion; a document linked from
several index pages; a step in a flow where the previous step varies. It is also
handy on mobile, where the browser's own back control is less obvious than on
desktop.

Two things are worth being clear about with any history-based control. First, it
depends on there *being* history to go back to: a visitor who arrives directly on a
deep link from an email or a search engine has none, so decide what the block
should do in that case before placing it prominently. Second, because the
destination is the browser's, not the site's, this is a *gesture*, not a navigation
structure — keep breadcrumbs or a real parent link for the structural relationship,
and use this for the "take me back" motion.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module — it has no configuration
form of its own. Everything is set on the block when you place it, described below.

## Where it lives in the admin menu

You work with it entirely from the **Block layout** page at **Structure → Block
layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout**.
2. In the region where you want the back link, click **Place block** and choose the
   **Go back history block**.
3. In the block's placement settings, adjust the usual options — the link label,
   which region it sits in, and **visibility conditions** (restrict it to certain
   content types, pages, roles, or a single theme).
4. Save the block. The back link now appears where you placed it and returns
   visitors to their previous page.
