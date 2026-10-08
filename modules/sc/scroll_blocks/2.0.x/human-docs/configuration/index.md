# Configuration

Scroll blocks is configured **per block placement** — there is no global settings
page. Each block you place gains an extra fieldset of pop-up options.

## Find the options

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a block (or edit an existing placement) in the region you want.
3. On the block's configuration form, open the Scroll blocks fieldset.

## The options

- **Enable popping up on this block** — tick this to turn the scroll behaviour on
  for this block. Once enabled, the block is **hidden by default** and slides up
  into view at the reveal distance below.
- **Reveal scroll distance** — after how many pixels of scrolling the block should
  slide up into view.
- **Hide scroll distance** — after how many pixels of scrolling the block should
  slide back down and hide again.
- **Min window width** — the block will only pop up if the browser window is at
  least this wide.
- **Max window width** — the block will only pop up if the browser window is
  narrower than this.

Between them, the min/max width options let you limit the behaviour to particular
screen sizes (for example, desktop only, or mobile only).

## Deciding which pages it appears on

The pop-up behaviour only runs when the block is actually rendered on the page, so
use core's normal **block visibility settings** (pages, content types, roles, and
so on) on the same configuration form to control where the block — and therefore
its scroll behaviour — appears.

## A close button

When a scroll block is showing, it includes a **close button**. Clicking it mutes
that block until the page is reloaded, so a visitor who dismisses it will not see
it slide up again on the same page view.

## Two things to check before deploying

- **Reduced motion.** Sliding a block into view is motion. Check what the shipped
  CSS does with `prefers-reduced-motion` and override it in your theme if it does
  nothing, so visitors who prefer reduced motion are respected.
- **Mobile overlap.** A block that appears over content can cover it on small
  screens. Test at mobile widths with the block visible, not just at desktop.
