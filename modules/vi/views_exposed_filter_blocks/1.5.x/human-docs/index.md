# Views exposed filter blocks — manual setup guide

**Views exposed filter blocks** (`views_exposed_filter_blocks`) lets you render a view's
**exposed filter form as a standalone block** that you can place in any region — completely
decoupled from where (or whether) the view's results appear. Normally a view's exposed
filters live right above its results; with this module you can move that search/filter form
into a sidebar, a header, or the highlighted region while the results render somewhere else
on the page.

That flexibility is what makes it useful for views that have no natural place for an exposed
form: an **EVA** display embedded in an entity, an **attachment** or feed display, a view
embedded via Twig or Layout Builder, or a masonry/slideshow style display. It works for
**any** view display plugin — `eva`, `page`, `block`, attachments — which is what sets it
apart from the similar *views_block_filter_block* module (that one is configured on the view
and only works for `block` displays). Here, everything is configured on the block itself.

The module ships exactly one block plugin and nothing else — **no settings page, no
permissions, no Drush, no plugin types**. Each block instance's only state is its two
settings, stored in that block's own configuration, so the whole setup exports and deploys as
regular config. The module works on **Drupal 8.9+, 9, 10, or 11** and depends only on core's
**Views** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. You place and configure the filter block from
**Structure → Block layout** (`/admin/structure/block`), like any other block.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place block** in
   the region where you want the filters to appear.
2. Search for **Views exposed filter block** (under the *Views Exposed Filter Blocks*
   category) and place it.
3. Configure the two settings:
   - **View & Display** — choose the view and display whose exposed filters this block should
     render (for example `content:page_1`). The list offers every enabled view display.
   - **Always process the form state** *(on by default)* — leave it on for the block to show
     and handle submitted filter values. Turn it **off** if the block should only *submit*
     values to the results view rather than reflect them itself.
4. Set the block's visibility and region as usual, and **Save**.

For the filters to actually reach the results, keep two things in mind: **disable AJAX** on
the target view, and keep the filter block and the results **on the same page** so the
filter's GET parameters are passed to the view. You can place several filter blocks on one
page, each targeting a different view/display. If you need the filters on a *different* page
than the results, point the target display's "custom URL" link setting at the results page —
the block will aim the form there.

Because each placed block is stored as a `block.block.<id>` configuration entity, you can
export the whole arrangement as config and deploy it across environments. To change the
markup of the exposed form itself, use core's `hook_form_views_exposed_form_alter()` — there
is no plugin here to extend.
