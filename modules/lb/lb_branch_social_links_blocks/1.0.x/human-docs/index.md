# Y Layout Builder — Branch Social Links — manual setup guide

**Y Layout Builder — Branch Social Links** (`lb_branch_social_links_blocks`) adds
a Layout Builder block type for a *location's own* social media accounts — a
branch's local Facebook page, an Instagram for its swim team — as distinct from
the organisation's national accounts. It is part of the YMCA Website Services
family of Layout Builder components (the `y_lb` package), and lets you place up
to six social links on a Branch page.

Keeping branch social links in their own block type preserves the distinction
that matters to a visitor: the accounts they would actually want are the ones the
local branch runs. Links are modelled as Paragraph items, and the block depends
on the **Link Attributes** module — a deliberate detail, because social links are
outbound and usually open in a new tab, and setting `rel="noopener"` alongside
`target="_blank"` (rather than trusting people to remember it) keeps the opened
page from getting a handle on yours.

This module is designed to be used **with the YMCA's Website Services
distribution**. Its hard dependency on **Y Layout Builder (`y_lb`)** means it is
not a standalone install — see [Installation](installation/index.md) for the
important note about where `y_lb` actually comes from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer/Drush
   commands, and the `y_lb` dependency caveat.

This module has **no configuration page** of its own. You place and edit the
social-links block from within the Layout Builder interface, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). Everything happens in
**Layout Builder**: edit a Branch page's layout, add the Branch Social Links
block, and fill in each link (URL, label, and link attributes) as Paragraph
items. For general Layout Builder mechanics, see Drupal core's Layout Builder.

## How to use it

1. Enable the module (and the rest of the YMCA Website Services / `y_lb` stack it
   belongs to).
2. Open a Branch page and enter its **Layout** (Layout Builder) editing screen.
3. **Add block** to the section where the social icons should appear and choose
   the Branch Social Links block.
4. Add each account (up to six) as a Paragraph item — the link URL and its
   attributes. Set `target="_blank"` and `rel="noopener"` via Link Attributes so
   outbound links open safely in a new tab.
5. Save the layout.
