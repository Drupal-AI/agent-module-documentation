# Configuration

Countdown has no central settings page — you configure each timer directly on the
**block instance** when you place it. That means every countdown is independent, so
you can run more than one, each pointing at a different moment.

## Place and configure a Countdown block

1. Log in as a user who can administer blocks, and go to **Structure → Block
   layout** (`/admin/structure/block`).
2. Choose a region and click **Place block**, then pick the **Countdown** block.
3. In the block configuration form, set:
   - The **target date/time** the timer counts to or from. A future moment counts
     **down** (time remaining); a past moment counts **up** (time elapsed).
   - The **display format** — whether to show only days, days plus hours, or the
     full days‑hours‑minutes‑seconds breakdown.
4. Set the standard block **visibility conditions** (which pages, roles, content
   types, etc. the countdown appears on).
5. Save the block.

## Running more than one

Because the configuration lives in the block instance, you can place the Countdown
block multiple times — a launch countdown in one region, a "days since" counter in
another — each with its own target and format.

## Good to know

- The timer runs in the **visitor's browser**, so it reflects the visitor's own
  clock, not the server's. This also means it needs no cache invalidation as time
  passes.
- Since the configuration is part of the block instance, it is included in your
  exported site configuration (`drush cex`) and travels with your deployments.
- To restrict where a countdown shows (for example, only on a campaign landing
  page), use the block's visibility settings — or pair it with a condition‑plugin
  module for finer targeting.
