# Configuration

ReadRemaining has one settings form that controls where the gauge appears and how
it looks and behaves.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → System → ReadRemaining**, or navigate directly to
   `/admin/config/system/readremaining`.

## What you can set

- **Content types** — tick the content types the gauge should be active on. This
  is the essential setting: with nothing selected, the gauge never loads. The
  library only attaches on nodes of the types you choose here.
- **DOM selector** — the element whose text the reading time is calculated from
  (for example `body`, `#content`, or a theme wrapper like `.my-wrapper`). Point
  it at the element that actually holds your article body for the most accurate
  estimate.
- **Look and feel** — choose between the gauge's dark and light styles to match
  your theme.
- **JavaScript settings** — the remaining options tune the ReadRemaining.js
  behavior, such as when the gauge appears and where it is placed. Adjust these
  only if the defaults don't suit your layout; the gauge works well as shipped.

## Save

Click **Save**, then view a node of one of the selected content types to see the
gauge. If you change the selected content types later, remember that the gauge
only appears on the ones currently ticked.
