# Contextual menu block — manual setup guide

**Contextual menu block** (`contextual_menu_block`) provides a menu block that
renders only the part of a menu relevant to the current page — the section the
visitor is in — instead of the whole menu tree or a fixed level. Place it once,
and it resolves its subtree from the page's active trail: it shows the immediate
parent and sibling menu items of the active item, or the active item's immediate
children. It deliberately keeps things simple and does *not* offer variable start
levels, depth, or the many options of the Menu Block module — no
parent‑of‑parent links, no child‑of‑child links.

This solves a common site‑building headache. Core's menu block shows a menu from a
fixed starting level, which is right for a main navigation but wrong for
per‑section sidebar navigation. On a site with eight top‑level sections, the usual
workaround is one block per section with path‑based visibility conditions — eight
blocks, eight sets of conditions, and a ninth section someone always forgets. A
single Contextual menu block replaces all of that. It has no dependencies and runs
on Drupal 9, 10, and 11.

Three things matter for correct behaviour. The **active trail must be right** — it
is for pages that are menu links, but not for pages reached another way (a view, a
taxonomy page, a node with no menu entry), so decide what those pages should show.
**Menu links respect access**, so a subtree is filtered by what the current user
may see, and an empty section for some role is a legitimate outcome, not a bug. And
the block is route‑dependent, so its **cache contexts** matter — the module
handles this so the first visitor's navigation is not cached and served to
everyone.

Most sites pair it with the
[Menu Breadcrumb](https://www.drupal.org/project/menu_breadcrumb) module, which
gives visitors a way to navigate *up* the hierarchy when the block does not render
a parent link (that is, when the active item has children).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. You place and
configure the block through the Block layout UI, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin settings page. You work with it entirely through
**Structure → Block layout** (`/admin/structure/block`), where you place the
**Contextual menu block**.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region
   where you want your section navigation (typically a sidebar).
2. Choose the **Contextual menu block** and select which menu it should draw from
   (for example your main navigation or a custom menu).
3. Configure the block's title, visibility, and region as usual, then save. It
   will now render the current page's section of that menu automatically on every
   page.
4. Optionally add the **Menu Breadcrumb** module so visitors can climb back up the
   hierarchy when the block only shows child links.
