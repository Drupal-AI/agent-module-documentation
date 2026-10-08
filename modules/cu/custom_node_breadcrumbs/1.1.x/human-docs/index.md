# Custom Node Breadcrumbs — manual setup guide

**Custom Node Breadcrumbs** (`custom_node_breadcrumbs`) gives every node its own
hand-picked breadcrumb trail. Instead of relying on Drupal's path-based
breadcrumb logic, you add a multi-value **link** field to your content and type
the exact trail you want, link by link, right on the node edit form. The module
then provides a block that reads those links on the current node and renders them
as the breadcrumb — and it emits breadcrumb structured data at the same time,
which helps search engines understand your page hierarchy.

This is handy for landing pages, campaign pages, or any content where the "true"
navigation path doesn't match the URL. Because authors set the trail per node,
editors stay in control and you avoid writing custom breadcrumb code. The block
prepends your site's front page as the "home" link automatically, so you only
need to supply the steps after home.

The module works as soon as you set up one field and place one block — there is
no settings form to fill in. It has no dependencies beyond Drupal core, and it
does nothing on nodes that don't have the breadcrumb field, so it's safe to
enable site-wide and use only where you need it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. All
the setup happens on a content type's fields and in the Block layout UI,
described in "How to use it" below.

## Where it lives in the admin menu

Custom Node Breadcrumbs adds no admin settings page of its own. You configure it
in two familiar places: **Structure → Content types → *(your type)* → Manage
fields** (to add the breadcrumb field) and **Structure → Block layout**
(`/admin/structure/block`, to place the breadcrumb block).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On each content type that needs custom breadcrumbs, add a **Link** field with
   the machine name `field_breadcrumbs`, and set it to allow **multiple** values
   (an unlimited number of links).
3. Edit a node and add the breadcrumb links in order — each entry is a **title**
   plus a **URL** (internal or external). These become the steps of the trail
   after the automatic "home" link.
4. Go to **Structure → Block layout**, place the **Custom Node Breadcrumb Block**
   (usually in your theme's breadcrumb region), and set any visibility conditions
   you want (for example, restrict it to certain content types).

Once placed, the block reads the current node's `field_breadcrumbs`, prepends the
front page as home, and renders the trail — along with matching structured data
for SEO. On a node that lacks the field, the block simply renders nothing, so it
is safe to leave in place across your whole site.
