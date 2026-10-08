# Configuration

The whole point of this module is its form, so "configuration" and "usage" are the
same thing here: you tick regions to disable their blocks and untick them to bring
the blocks back.

## Open the form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to `/admin/config/disable_enable_all_assign_block` for the module's section,
   and to its settings form at the route
   `disable_enable_all_assign_block.settings_advanced`
   (`/admin/config/disable_enable_all_assign_block/deaab_settings_advanced`).

## Toggle regions

The form lists the regions of your site's **default theme** as checkboxes. The
meaning of each checkbox is:

- **Ticked (checked)** — every block assigned to that region is **disabled**.
- **Unticked (unchecked)** — every block assigned to that region is **enabled**.

So to hide, say, the right sidebar during a campaign, tick its region and save; to
restore it later, untick the region and save again. When you submit the form, the
module goes through the default theme's blocks and saves each one to match the
region's new state. Your selection is persisted as configuration
(`disable_enable_all_assign_block.settings_advanced`), so it is exportable and moves
with your config between environments.

## Things to watch

- **The toggle is region-wide.** Unticking a region re-enables *all* of its blocks,
  including any you had disabled individually elsewhere. If you have blocks in a
  region that should stay off, this bulk toggle is not the tool for keeping them
  off.
- **It operates on the default theme only.** Blocks placed in other themes are not
  affected.
- **It is admin-only.** The operation is powerful, and it is gated behind
  **Administer site configuration** — there are no anonymous or web-service routes.
