# Solo Utilities — manual setup guide

**Solo Utilities** (`solo_utilities`) is a companion module for the **Solo** theme
(by Flash Web Center). It adds three site-building extras aimed at Solo-based
sites: conditional colour-scheme loading, per-block title visibility and heading
control, and per-node custom width classes.

Every feature is deliberately inert unless Solo — or a sub-theme built on Solo — is
your active default front-end theme. On any other theme the module quietly does
nothing, so it is safe to have enabled without side effects.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The one dedicated admin screen is the **Color Schemes Rules** list at
**Configuration → Solo Utilities → Color Schemes Rules**
(`/admin/config/solo_utilities/color-schemes-rules`). The other two features do
not have their own pages — they are switched on from the **Solo theme's own
settings form** and then appear on the block and node forms you already use.

## How to use it

### 1. Color Schemes Rules

A Color Schemes Rule pairs a set of conditions with one of Solo's predefined
colour-scheme libraries. On every page, the rules are evaluated in order and the
first matching rule's colour scheme is loaded. Create and manage rules at
**Configuration → Solo Utilities → Color Schemes Rules**; each rule has:

- a **label** and an **enabled** toggle,
- one or more core **Condition** plugins (for example request path or content
  type), with an **AND/OR** conjunction and an optional **negate** per condition,
- the **colour scheme** to load when the rule matches.

Order matters — the first matching rule wins, so a single scheme is chosen per
request. Typical uses: load a special scheme only on the front page, apply an
alternate scheme to a section by path, or switch scheme by content type.

Managing rules requires the Solo theme to be active plus one of the module's
Color Schemes Rules permissions (see below).

### 2. Block title visibility and tag

Turn on the Solo theme setting **Enable block title visibility**. Once on, the
block configuration form replaces core's single "Display title" checkbox with two
selects placed after the block **Title** field:

- **Title visibility** — **Visible**, **Visually hidden** (present for
  screen-readers only), or **None** (not rendered at all).
- **Title tag** — the heading wrapper: `h1`–`h6` (default `h2`) or `div`, so you
  can fix heading hierarchy or drop a title out of the document outline.

When you first enable the module, existing core "display title" settings are
migrated into this richer model automatically, and cleaned up again on uninstall.

### 3. Custom node widths

Turn on the Solo theme setting **Enable custom node width**. Node add/edit forms
then gain a **Custom Width** select with options such as `sw-800`, `sw-1024`,
`sw-1280` … up to `sw-2560`, plus `sw-100` (100%) and **None**. The chosen class is
stored per node (as content, not exported config) and the theme applies it when
rendering the node. Choosing **None** removes the stored width.

## Permissions

The Color Schemes Rules admin UI is gated by granular permissions —
**Administer**, **View**, **Create**, **Edit**, and **Delete Color Schemes
Rules** — all of which also require Solo (or a Solo sub-theme) to be the active
default theme. The block-title and node-width features piggy-back on core block
and node edit access plus the Solo theme settings, so they need no extra
permission.
