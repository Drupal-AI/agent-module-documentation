# Configuration

Last Visited Pages has a small settings form for the history block, and the
history is displayed by placing the block itself. The module stores up to the last
20 pages per user; the setting here controls how many of those the block shows.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Last Visited Pages**, or navigate
   directly to `/admin/config/last-visited-pages-settings`.

## The setting

- **Number of links to display** — how many recent pages the block lists. The
  module retains up to 20 visits per user internally; this value limits how many
  of them are rendered in the block. Set it lower for a compact widget in a
  sidebar or footer, higher for a fuller history.

Click **Save configuration** to apply.

## Place the history block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the history (a sidebar or
   footer is typical), find **Last Visited Pages**, and place it.
3. Use the block's standard visibility settings to restrict where and to whom it
   appears — for example, showing it only to authenticated users.

## Privacy considerations worth revisiting

Because the module records each user's browsing history, decide deliberately:

- **Anonymous users** — whether they should be tracked at all. Anonymous visitors
  are far more numerous, their history is less useful to them, and tracking them
  is more of a storage and privacy question. If the benefit is only meaningful to
  logged‑in users, keep the block (and the feature's value) scoped to them.
- **Retention and storage** — be aware of where the history lives and how long it
  is kept, and make sure the people being tracked can actually see the feature
  that benefits from it.
