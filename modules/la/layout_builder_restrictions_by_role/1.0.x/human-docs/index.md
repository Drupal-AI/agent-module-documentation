# Layout Builder Restrictions By Role — manual setup guide

**Layout Builder Restrictions By Role** (`layout_builder_restrictions_by_role`)
is an add-on for the
[Layout Builder Restrictions](https://www.drupal.org/project/layout_builder_restrictions)
module that lets you control, **per user role**, which blocks an editor may place
and which layouts they may use in Layout Builder. Give your marketing editors
only the approved marketing blocks, keep experimental layouts away from junior
authors, and hand more capable editors a wider palette — all without code.

It registers a Layout Builder Restrictions plugin called **Per Role**. Once you
enable that plugin, you define restrictions in two places: a set of **global
defaults** that apply everywhere Layout Builder is used, and optional
**per-view-mode overrides** for special cases (say a particular bundle's layout).
For each role and each block category you choose a rule type: *all* (no
restriction), *whitelist* (only the blocks you list are allowed), or *blacklist*
(the blocks you list are denied). Layouts are allowed per role too, and you can
even allow or deny a block only within a specific layout.

Two behaviors are worth understanding up front. First, evaluation is
**most-permissive-wins**: if a user has several roles, a block or layout is
allowed as long as *any* of their roles allows it — mirroring how Drupal grants
access generally. Second, this is a **refinement layer for editors who already
have Layout Builder editing rights**, not a security boundary against untrusted
users; if a display has no restriction data it allows everything (fail-open). Both
are by design.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Layout Builder Restrictions.

## How to use it

### 1. Enable the "Per Role" plugin

Restrictions won't appear until you switch this plugin on. Go to
**Structure → Layout Builder Restrictions** and enable the **Per Role**
restriction. Only then does the per-role configuration (and its enforcement) show
up.

### 2. Set global defaults

The global defaults apply everywhere Layout Builder is used. There are admin forms
(all requiring Layout Builder Restrictions' own **`configure layout builder
restrictions`** permission) for:

- **Allowed layouts** — at
  `/admin/config/content/layout-builder-restrictions/by-role`, choose which roles
  may use which layout plugins.
- **Allowed blocks** — which blocks each role may place, per block category, as an
  *all* / *whitelist* / *blacklist* rule.
- **Layout-specific block rules** — allow or deny particular blocks only inside a
  particular layout.

### 3. Override for a specific view mode (optional)

On an entity's **Manage display** screen for a Layout Builder-enabled view mode,
you'll find the same per-role block/layout controls. A view mode uses the global
defaults **unless** you turn on its *override defaults* option, at which point it
uses its own settings instead. Use this for one-off bundles that need a different
palette from the rest of the site.

### Good to know

- **Custom content blocks** get special handling: with no "Custom blocks" rule the
  plugin matches on the block *type*; add a "Custom blocks" rule to match the whole
  category.
- All of this only narrows what already-privileged Layout Builder editors can do.
  It reduces clutter and enforces a design system — it does not replace Layout
  Builder's own access permissions.

## Where it lives in the admin menu

Configuration lives inside **Structure → Layout Builder Restrictions** (enable the
*Per Role* plugin and edit the global defaults there) and on each entity's
**Manage display** screen (for per-view-mode overrides). There is no separate
top-level settings page for this module.
