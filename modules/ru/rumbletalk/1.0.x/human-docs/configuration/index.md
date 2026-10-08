# Configuration

RumbleTalk is configured entirely through Drupal's **block** system — there's no
separate settings page. The one essential value you need is your **chat ID** (the
hash that identifies your RumbleTalk room), which you get from your RumbleTalk
account.

## Step 1 — Get your RumbleTalk chat ID

1. Log in to your account at [rumbletalk.com](https://rumbletalk.com/).
2. Create (or open) the chat room you want to embed, and pick or design its theme.
3. Find the room's **chat ID / hash** — the identifier RumbleTalk gives for embedding
   the room. Keep it handy for the next step.

## Step 2 — Place the chat block

1. In Drupal, go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the chat to appear (for example
   the content area or a sidebar).
3. Choose the **RumbleTalk** chat block from the list.

## Step 3 — Enter the chat ID and set visibility

In the block's configuration form:

- **Chat ID / hash** — paste the identifier from Step 1. This tells the widget which
  RumbleTalk room to load. (Without it, the block has no room to display.)
- **Visibility** — restrict where the chat shows using the standard block visibility
  conditions (specific pages, content types, or roles). Since the chat is public to
  whoever can see the block, use these settings to scope it to the right audience —
  for example only your live‑event page.
- **Title / region** — set the block title and confirm the region as usual.

Click **Save block**. Visit a page where the block is shown and confirm the RumbleTalk
chat room loads and works.

## Privacy note

Remember that the chat itself runs on RumbleTalk's service and loads RumbleTalk's
JavaScript into your pages, and that messages and participant data are handled by
RumbleTalk rather than your Drupal site. Depending on your jurisdiction and audience,
you may need to mention this in your privacy policy or cookie/consent notice.
