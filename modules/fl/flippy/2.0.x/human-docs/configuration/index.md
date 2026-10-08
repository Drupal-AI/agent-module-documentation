# Configuration

Flippy is configured per content type, then positioned on the page. There is no
central settings form.

## Turn Flippy on for a content type

1. Go to **Structure → Content types → (your type) → Edit**
   (`/admin/structure/types/manage/<type>`).
2. Open the collapsible **Flippy settings** group.
3. Tick the master **Flippy** option to build a pager for this content type, then
   set the options below.
4. **Save content type**.

## The Flippy settings

- **Enable Flippy** — the master on/off switch for this content type.
- **Add head links** — add semantic `rel="prev"` / `rel="next"` `<link>` tags to
  the page's `<head>` (useful for SEO).
- **Show empty labels** — render a label with no link when there is no
  previous/next node, rather than hiding it.
- **Previous label** / **Next label** — the text for the Previous and Next links.
  These support tokens, so you can show the target node's title, e.g. `Next:
  [node:title]`.
- **First and Last** — show First and Last links, with their own **First label**
  and **Last label**.
- **Loop** — wrap around so Next on the last node goes to the first (and Prev on
  the first node goes to the last).
- **Random** — show a Random link, with its own **Random label**, that jumps to a
  random node of the same type.
- **Truncate** — a maximum label length after token replacement (leave empty for
  no truncation), and **Ellipsis** — the string appended when a label is
  truncated.
- **Keyboard/swipe navigation** — arrow-key and touch-swipe paging. This option is
  only offered when the HammerJS module is enabled.
- **Custom sorting** — by default the pager follows post date, oldest first. Turn
  this on to sort by something else, then choose:
  - **Sort field** — the field or property to sort by. (The list offers base
    fields and fields whose value is text, integer, or datetime.)
  - **Sort order** — ascending (`ASC`) or descending (`DESC`).

## Position the pager on the node

Once Flippy is enabled for a type, a **Flippy pager** pseudo-field appears on that
type's display settings:

1. Go to **Structure → Content types → (your type) → Manage display**
   (`/admin/structure/types/manage/<type>/display`).
2. Drag the **Flippy pager** row to where you want it among the node's fields (for
   example just below the body), or leave it disabled if you would rather place it
   as a block.

## Or place the Flippy Block

Instead of (or in addition to) the pseudo-field you can place the pager anywhere:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** for the region you want, find **Flippy Block**, and place
   it. The block only renders on node pages of a content type that has Flippy
   enabled.

## Per-type independence

Each content type has its own Flippy settings and its own pager sequence — Flippy
never pages across different content types at once. Configure each type
separately.

## Deploying and theming

All settings are stored in one exportable configuration object (as per-type keys),
so they move between environments with your exported configuration. If you need to
change the pager's markup, you can override its Twig template — see the
[`agent/`](../../agent/theming/templates.md) docs for the theme hook and template
suggestions (including per-type and per-node overrides).
