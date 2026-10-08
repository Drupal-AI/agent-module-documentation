# Configuration

You build and manage pages through the **Page Manager UI** wizard, so this page
assumes you enabled the `page_manager_ui` submodule during
[installation](../installation/index.md). Everything lives at **Structure → Pages**
(`/admin/structure/pages`) and is gated by the **Administer pages** permission.

## The Pages listing

Go to **Structure → Pages**. This screen lists every Page Manager page and gives you
an **Add page** button. It also shows any pages that ship as examples — notably a
**Node view** page that is set up to override `/node/{node}` (disabled or ready for
you to customize, depending on your setup).

## Add a page

Click **Add page** to start the wizard. The key things you set are:

- **Label** and **machine name** — a human name and its internal id.
- **Path** — the URL the page answers on. It can include typed parameters in curly
  braces, for example `/my-section/{node}`. A parameter like `{node}` can be mapped
  to an entity type so it is "upcast" to a loaded node and made available to the
  page's variants and blocks.
- **Use admin theme** — whether the page renders with the administration theme.
- **Access** — optional access conditions (and whether they combine with AND or OR
  logic) that decide who may *view* the page. These are separate from the
  `administer pages` permission, which only governs who may *build* pages.

Because a page can override an existing route (the shipped example overrides
`/node/{node}`), Page Manager only takes the route over when one of the page's
variants actually matches; otherwise it steps aside and the original route still
works.

## Add and configure variants

A page renders through one or more **variants**, and this is where the real layout
choices happen. For each variant you set:

- **Variant type** — the display variant plugin that renders the output. The
  built-in choices are:
  - **Block display** (`block_display`) — place blocks into the regions of a chosen
    layout, region by region. This is the classic "build a page out of blocks" option.
  - **HTTP status code** (`http_status_code`) — return a bare status such as 403,
    404, or 500 for the matched route.
  - **Layout Builder** (`layout_builder`) — hand rendering off to core Layout
    Builder.
  - If you installed **Panels**, a **Panels** variant adds selectable layouts with
    drag-and-drop block placement.
- **Selection criteria** — conditions (role, path, language, entity bundle, and so
  on) that decide *when* this variant applies, combined with AND or OR logic.
- **Weight / order** — when a page has several variants, Page Manager renders the
  first one, in weight order, whose selection criteria pass. Order your variants so
  the most specific ones come first and a general fallback comes last.
- **Static contexts** — optional fixed contexts (for example a specific entity) you
  attach to the variant so its blocks can use them.

For a Block display variant, you then choose a layout and drag blocks into its
regions. Blocks placed here can consume the page's contexts — the node or user from
the URL, the current user, the interface language — so you can, for instance, show a
block that renders the current node's fields.

## Typical recipes

- **A brand-new landing page** — add a page at a fresh path like `/welcome`, add one
  Block display variant, pick a layout, and place your blocks.
- **Override the node page** — add a page at `/node/{node}`, map `{node}` to the node
  entity type, and build a Block display (or Layout Builder) variant. Use selection
  criteria on a variant so the takeover only applies to the content types you intend,
  letting other node types fall back to core.
- **Role-specific layouts** — add two variants with different selection criteria
  (for example one requiring an "editor" role), ordered so the more specific one wins.
- **A 404 for a route** — add a variant of type HTTP status code returning 404.

## Save and deploy

Save the page. Because pages and variants are stored as configuration, you can
export them with `drush config:export` and deploy the exact same pages to another
environment. Reorder variants and adjust access rules at any time through the same
Structure → Pages wizard.
