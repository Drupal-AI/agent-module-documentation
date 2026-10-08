Empty Page creates blank menu callbacks — routes that render an empty page — so you can build pages made entirely of blocks, or override an existing path (like the front page) with nothing.

---

Through an admin screen at `/admin/structure/empty-page` (route `empty_page.administration`) you add "callbacks", each defined by an internal path and an optional page title. Each callback is stored in the config object `empty_page.settings` as a `callback_<cid>` entry (`{cid, path, page_title, created, updated}`) alongside a `new_id` counter. A route-callbacks subscriber (`\Drupal\empty_page\Routing\EmptyPages::routes`) reads those config entries at route-build time and registers one dynamic route per callback (`empty_page.page_<cid>`) whose controller (`EmptyPage::emptyCallback`) returns an empty render array with the configured title, gated by the `view empty pages` permission. Because the page body is empty, whatever blocks you place on that path via the Block layout become the entire page — ideal for block-built landing pages or for blanking out a default listing (e.g. replacing the default `/node` front-page list). Administration is gated by `administer empty pages`. The module has no dependencies beyond core and no config schema.

---

- Create a blank landing page whose content comes entirely from placed blocks.
- Override the default front page (`/node`) so the promoted-node list disappears.
- Build a "dashboard" path populated only with blocks and views blocks.
- Provide an empty menu callback to hang a menu item on for a blocks-only section.
- Make a marketing page assembled from reusable blocks with no node behind it.
- Give a custom path a title without creating a node or view.
- Replace a legacy path with an empty, block-driven page.
- Create a placeholder route while a section is under construction.
- Set up a homepage that is composed with Layout/Block placement instead of content.
- Add several empty pages for different site sections, each block-built.
- Provide a target path for contextual/region blocks to appear on.
- Blank out an existing listing path by claiming it with an empty page.
- Create a login-adjacent or utility page that only shows a block.
- Offer editors a stable URL for block-based promotional content.
- Restrict who can view empty pages via the `view empty pages` permission.
- Restrict who can manage callbacks via the `administer empty pages` permission.
- Edit a callback's path or title later from the admin list.
- Delete an empty-page callback (and its dynamic route) when no longer needed.
- Deploy empty-page callbacks as configuration (`empty_page.settings`) across environments.
- Create a full-width block canvas page without installing Panels or Layout Builder.
- Quickly prototype a page structure using only blocks.
- Provide a container route for a Views block-only listing page.
- Set a friendly page title on an otherwise block-only path.
