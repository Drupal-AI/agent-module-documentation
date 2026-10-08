# Configuration

LocalGov Core has no settings form. What you configure are the blocks it provides,
the shared fields it declares, and the submodules you enabled. This page walks
through the parts you interact with directly.

## The Page Header block

This is the module's headline feature. It renders a page header — a title, an
optional subtitle, and an optional lede — derived from the current route's entity
or View.

- **Place it** at **Structure → Block layout** (`/admin/structure/block`): find the
  **Page header** block and place it in the region your theme uses for page
  headers. (In a full LocalGov site the theme usually places it for you.)
- **Theme it per content type.** The block supports template suggestions such as
  `localgov_page_header_block__{bundle}`, so you can provide a custom template for a
  particular content type.
- **Drive it from a View.** A Views display extender lets a View page supply the
  header title and lede, so listing pages can have a proper header too.
- **Override it in code.** The block fires a `PageHeaderDisplayEvent`; an event
  subscriber can change the title, subtitle, lede, cache tags, or hide the block on
  specific routes. See the [`agent/`](../../agent/api/services.md) docs for the
  event API.

## The "Powered by LocalGov Drupal" block

A simple attribution block that outputs a "Powered by LocalGov Drupal" line. Place
it from **Structure → Block layout** if you want the credit in a region (its label
is hidden by default).

## The read-only entity-reference labels widget

The module provides a field widget, **LocalGov entity reference labels**, for
`entity_reference` fields. It shows the referenced entities as read-only labels
(with the order still editable by drag-and-drop) instead of an autocomplete box —
useful on overview or landing pages where the references are populated elsewhere but
you still want to reorder them. Choose it on the field's **Manage form display**
tab.

## Linkit autocomplete matchers

If you use Linkit for link autocomplete, LocalGov Core adds refined matchers — most
notably one that prefixes "Unpublished:" in front of unpublished nodes in the
autocomplete results, so editors can tell at a glance. These take effect through
your Linkit profile configuration.

## Document link file metadata

The module's file-link preprocess automatically appends the file **type**
(uppercased extension) and a human-readable **size** to document download links, and
for document media it can use the file description or media name as the link text
(controlled by the field display setting). This applies wherever file links are
rendered — no separate configuration is required beyond the field display option.

## Shared fields and view mode provided

On install the module declares reusable configuration you can attach to your content
types:

- Field storages: **localgov_email_address**, **localgov_phone**,
  **localgov_facebook**, **localgov_twitter**, and **localgov_summary** — shared
  social/contact and summary fields.
- A **localgov_card** node view mode for teaser/card rendering.

## Submodule features

- **LocalGov Roles** creates the standard editorial roles and lets modules declare
  default permissions via `hook_localgov_roles_default()`.
- **LocalGov Admin Role** creates an all-permissions admin role.
- **LocalGov Media** installs a media configuration bundle.
- **LocalGov Admin Theme Improvements** applies admin-theme CSS/JS fixes.

Each has its own documentation; see the submodule `agent/` docs linked from the
[agent index](../../agent/start.md).

## Default block placement (for developers)

The module ships a **default block installer** service that reads
`config/localgov/block.*.yml` files from LocalGov modules and places those blocks
into theme regions automatically when a module is enabled (and during a
distribution's post-install). If you build a LocalGov module, you can rely on this
to place your default blocks rather than doing it by hand.
