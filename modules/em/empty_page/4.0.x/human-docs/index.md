# Empty Page — manual setup guide

**Empty Page** (`empty_page`) creates blank menu callbacks — routes that render an
empty page with nothing but an optional title. On its own that sounds useless, but
it is exactly what you want when you build a page **entirely out of blocks**:
because the page body is empty, whatever blocks you place on that path become the
whole page. It is a lightweight way to make block-driven landing pages, dashboards,
and section fronts without installing Panels or Layout Builder.

The other common use is *blanking out* an existing path. Point an empty page at a
path like `node` and the default promoted-content list disappears, leaving you free
to compose the front page from blocks instead.

You manage these routes on a small admin screen, adding "callbacks" — each just an
internal path plus an optional page title. Each callback becomes its own dynamic
route, and the router is rebuilt automatically when you save. The module has no
dependencies beyond Drupal core, and two permissions control who can manage
callbacks and who can view the resulting pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The callback manager sits at **Structure → Empty Page**
(`/admin/structure/empty-page`) and requires the *Administer empty pages*
permission.

## How to use it

1. Enable the module, then go to **Structure → Empty Page**
   (`/admin/structure/empty-page`).
2. Click **Add** and fill in two fields:
   - **Path** — the internal path for the page, with no leading slash (for example
     `my-landing`, or `node` to blank the default front-page listing).
   - **Page title** — an optional title shown at the top of the page.
   Save. The dynamic route is created immediately.
3. Go to **Structure → Block layout** and place whatever blocks you want on that
   path (use each block's visibility settings, or a Views block, to target it).
   Those blocks become the entire page.
4. Under **People → Permissions**, grant **View empty pages** to the roles that
   should be able to reach the page (commonly Anonymous and Authenticated) —
   without it, visitors cannot view the generated pages. Keep **Administer empty
   pages** to trusted roles only.

You can edit a callback's path or title, or delete it, later from the same admin
list; deleting it removes its route. Callbacks are stored as configuration
(`empty_page.settings`), so they can be deployed between environments.
