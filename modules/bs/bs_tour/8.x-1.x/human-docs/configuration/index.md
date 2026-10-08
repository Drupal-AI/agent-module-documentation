# Configuration

Setting up a tour has two parts: defining the steps, and placing the block that
renders them.

## Define the tour steps

1. Log in as a user with the **administer bs tour** permission. This is a
   dedicated, access-restricted permission — grant it only to trusted admins.
2. Go to **Configuration → User interface → BS Tour**, or navigate directly to
   `/admin/config/user-interface/bs-tour`.
3. Add the steps of your tour. Each step anchors to an element on the page (via a
   CSS selector) and carries the popover text the visitor sees. The steps are
   stored in the module's configuration, so they travel with your config exports.

## Place the tour block

The tour only runs where you place its block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **BS Tour** block in a region.
3. Use the block's **Visibility** settings to limit it to the pages (and,
   through role-aware visibility, the audiences) where the tour should run. The
   selectors your steps point at must exist on those pages for the popovers to
   anchor correctly.

Because placement is what activates the tour, you can run different tours on
different pages, or keep a tour off the rest of the site, purely through block
placement and visibility — no code required.
