# Configuration

Setting up Notification System has two parts: **mapping your providers into
groups** so notifications are organised the way you want, and **placing the
block** so users can see them. Neither step invents notifications — those come
from provider plugins — so make sure you have at least one provider available
first.

## Map providers into notification groups

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/structure/notification-group/mapping`**.

A `notification_group` is a named, described bucket that one or more providers
feed into — for example a "Content updates" group and a "System alerts" group.
On the mapping form you associate each available provider with the group it
belongs to, and you can give each group a human‑readable description (formatted
text) that users will see. Grouping is what makes the **bundled** display mode
useful: notifications appear organised under their group headings rather than as
one flat list.

If you only have a single provider and want the simplest possible experience,
you can leave everything in one group and use the simple (dropdown) display
instead.

## Place the notification block

The user‑facing part is a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **Notification System** block and place it in a region — the header
   is the natural home for a bell/notification dropdown.
3. In the block's own settings, choose the **display mode**:
   - **simple** — a single dropdown listing the current user's unread
     notifications.
   - **bundled** — notifications grouped under their notification‑group
     headings.
4. Choose how the notifications load. By default they are fetched over **AJAX**
   so the block can update without a full page reload; you can instead have them
   **rendered inline** with the page. There is also an option to show
   already‑read notifications on request rather than only unread ones.
5. Restrict the block's visibility to authenticated users if your notifications
   are only meaningful to logged‑in accounts.

Save the block. Each user now sees only their own notifications — the block and
its routes are always scoped to the current account.

## Theming (optional)

The block renders through ordinary Twig templates —
`notification-block.html.twig`, `notification-group.html.twig`, and
`notification-item.html.twig` — which autoescape notification titles and bodies.
Override these in your theme if you want to change the markup or styling of the
dropdown, the group headings, or individual items.
