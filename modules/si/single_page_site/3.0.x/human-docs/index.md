# Single Page Site — manual setup guide

**Single Page Site** (`single_page_site`) builds a one-page website out of an existing
menu. It renders the content behind every item in a menu you choose onto a single
page, and rewrites that menu's links so they jump to anchors on the page instead of
navigating away.

The one-pager — a product launch, a conference, a small organisation — is a whole
genre of site, and building one in Drupal normally means either a single enormous node
or a stack of paragraphs that duplicates content already living in your nodes. This
module takes a third route: keep the nodes, keep the menu, and let the menu define the
page order. You point it at a menu, and it assembles the linked content into one page,
served at `/single-page-site`, with the menu's links turned into smooth in-page
anchors.

It depends on core's **Menu Link Content** module. Two permissions ship —
**Administer single page site** and **View single page site** — so the assembled page
can be restricted independently of the underlying content. Keep in mind that the
module renders your nodes into the page, so a viewer sees whatever the normal render
pipeline would give them for those nodes. An optional submodule,
**single_page_site_next_page**, adds a "scroll to next page" link at the bottom of
each section.

A key setup detail: the link-rewriting needs to know where your menu lives in the
page, so you tell the module the CSS class or id of your theme's menu wrapper. That
part is theme-specific — a value like `#block-themename-main-menu` depends on your
theme's block id — so it is worth testing against your actual theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it (plus the optional next-page submodule).
2. [Configuration](configuration/index.md) — choose the menu, set the wrapper and item
   classes, and control which items appear.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Single Page Site**
(`/admin/config/system/single-page-site`). The assembled one-pager itself is served at
**`/single-page-site`**.
